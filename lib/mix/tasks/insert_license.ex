defmodule Mix.Tasks.InsertLicense do
  @doc false

  use Mix.Task

  def run(opts \\ []) do
    case OptionParser.parse(opts, strict: [license: :string, verify: :boolean]) do
      {[verify: true, license: license], _argv, _errors} ->
        with {:ok, license} <- cast(String.upcase(license)),
             true <- ExLicense.with_header?(license) do
          exit({:shutdown, 0})
        else
          :error ->
            Mix.shell().error("you pass an invalid license")
            Mix.shell().info("you should pass 'mit,agpl, gpl, lgpl, mozilla, apache, boost'")
            exit({:shutdown, 1})

          false ->
            Mix.shell().error("Files do not start with the license header")
            Mix.shell().info("Be sure to have a license header or run mix insert_license")
            exit({:shutdown, 1})
        end

      {[{:license, license} | _], _argv, _errors} ->
        case cast(String.upcase(license)) do
          {:ok, license} ->
            ExLicense.insert_header(license)

          :error ->
            Mix.shell().error("you pass an invalid license")
            Mix.shell().info("you should pass 'mit,agpl, gpl, lgpl, mozilla, apache, boost'")
            exit({:shutdown, 1})
        end

      _ ->
        Mix.shell().info(
          "You have to pass --license flag and --verify if you can check all the files"
        )

        exit({:shutdown, 1})
    end
  end

  defp cast("MIT"), do: {:ok, :mit}
  defp cast("AGPL"), do: {:ok, :agpl_v3}
  defp cast("GPL"), do: {:ok, :gpl_v3}
  defp cast("LGPL"), do: {:ok, :lgpl_v3}
  defp cast("MOZILLA"), do: {:ok, :mozilla_v2}
  defp cast("APACHE"), do: {:ok, :apache_v2}
  defp cast("BOOST"), do: {:ok, :boost_v1}
  defp cast(_), do: :error
end
