defmodule Midi do
  defstruct(content: <<>>)
  
  defmodule Frame do
    defstruct(
      type: "xxxx",
      length: 0,
      data: <<>>
    )
    
    def to_binary(%Midi.Frame{type: type, length: length, data: data}) do
      <<
        type::binary-4,
        length::integer-32,
        data::binary
      >>
    end
  end
  
  def from_file(name) do
    %Midi{content: File.read!(name)}
  end
  defimpl Enumerable, for: Midi do
    def _reduce(_content, {:halt, acc}, _fun) do
      {:halted, acc}
    end
    
    def _reduce(content, {:suspend, acc}, fun) do
      {:suspended, acc, &_reduce(content, &1, fun)}
    end
    
    def _reduce(_content = "", {:cont, acc}, _fun) do
      {:done, acc}
    end
    
    def _reduce(<<
                  type::binary-4,
                  length::integer-32,
                  data::binary-size(length),
                  rest::binary
                >>,
                {:cont, acc},
                fun) do
      frame = %Midi.Frame{type: type, length: length, data: data}
      _reduce(rest, fun.(frame, acc), fun)
    end
    
    def reduce(%Midi{content: content}, state, fun) do
      _reduce(content, state, fun)
    end
    
    def count(midi = %Midi{}) do
      frame_count = Enum.reduce(midi, 0, fn (_, count) -> count + 1 end)
      {:ok, frame_count}
    end
    
    def member?(%Midi{}, %Midi.Frame{}) do
      {:error, __MODULE__}
    end
    
    def slice(%Midi{}) do
      {:error, __MODULE__}
    end
  end
  
  defimpl Collectable, for: Midi do
    use Bitwise
    
    def into(%Midi{content: content}) do
      {
        content,
        fn
          acc, {:cont, frame = %Midi.Frame{}} ->
            acc <> Midi.Frame.to_binary(frame)
          acc, :done ->
            %Midi{content: acc}
          _, :halt ->
            :ok
        end
      }  
    end
  end
  
  defimpl Inspect, for: Midi do
    def inspect(%Midi{content: <<>>}, _opts) do
      "#Midi[<<empty>>]"
    end
    
    def inspect(midi = %Midi{}, _opts) do
      content = 
        Enum.map(midi, fn frame -> Kernel.inspect(frame) end)
        |> Enum.join("|n")
      "#Midi[\n#{content}\n]"
    end
  end
  
  defimpl Inspect, for: Midi.Frame do
    def inspect(%Midi.Frame{type: "MThd",
                            length: 6,
                            data: <<
                                format::integer-16,
                                tracks::integer-16,
                                division::bits-16
                                >>},
              _opts) do
      beats = decode(division)
      "#Midi.Header{Midi format: #{format}, tracks: #{tracks}, timing: #{beats}}"
    end
    
    def inspect(%Midi.Frame{type: "MTrk", length: length, data: data}, _opts) do
      "#Midi.Track{length: #{length}, data: #{Kernel.inspect(data)}}"
    end
    
    defp decode(<<0::1, beats::15>>) do
      "♩ = #{beats}"
    end
    
    defp decode(<<1::1, fps::7, beats::8>>) do
      "#{-fps} fps, #{beats}/frame"
    end
  end
end