defmodule ElixirMailman do

  def main do
    case System.argv do
      [action | args] ->
        init [userStore]
        actions[action].(args)
      _               -> IO.puts "ElixirMailman.main: bad arguments."
    end
  end

  defp init directories do
    Enum.map directories, (fn directory ->
        unless File.exists? directory do
          File.mkdir directory
        end
      end)
  end
  
  defp actions, do: %{
    "send" => &sendAction/1,
    "view" => &viewAction/1
  }

  defp storeDirectory user do
    if (Path.dirname user) == "/home" do
      "#{user}/.elixir_mailman"
    else
      "/home/#{user}/.elixir_mailman"
    end
  end
    
  defp userStore, do: storeDirectory System.user_home

  defp sendAction [receiver, file] do
    ## <<< DEBUG
    IO.puts "ElixirMailman.sendAction: 'storeDirectory receiver' = '#{storeDirectory receiver}'; 'file' = '#{file}'; 'Path.basename file' = '#{Path.basename file}'"
    ## >>>
    File.copy file, "#{storeDirectory receiver}/#{Path.basename file}"
  end
  defp sendAction _ do
    IO.puts "ElixirMailman.sendAction: bad arguments."
  end

  defp viewAction [file] do
    ## <<< DEBUG
    IO.puts "ElixirMailman.viewAction: 'userStore' = '#{userStore}'; 'file' = '#{file}'"
    ## >>>
    IO.puts (File.read! "#{userStore}/#{file}")
  end
  defp viewAction _ do
    IO.puts "ElixirMailman.viewAction: bad arguments."
  end
  
end
