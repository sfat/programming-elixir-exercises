defmodule SystemEnvironmentVariable do
    def get_variable(env) do
        System.get_env(env)
    end
end
