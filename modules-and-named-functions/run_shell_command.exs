defmodule ShellCommand do
    def run(command), do: System.cmd(command, [])
end
