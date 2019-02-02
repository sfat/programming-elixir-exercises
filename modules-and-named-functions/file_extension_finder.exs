defmodule FileExtensionFinder do
    def find_extension(file) do
        Path.extname(file)
    end
end
