defmodule Mix.Tasks.InsertLicense do
  @doc false

  use Mix.Task

  def run(opts \\ []) do
    case OptionParser.parse(opts, strict: [license: :string, verify: :boolean]) do
      {[verify: true, license: license], _argv, _errors} ->
        case cast(String.upcase(license)) do
          {:ok, license} ->
            verify(license)

          :error ->
            Mix.shell().error("you pass an invalid license")
            Mix.shell().info("you should pass 'mit,agpl, gpl, lgpl, mozilla, apache, boost'")
        end

      {[{:license, license} | _], _argv, _errors} ->
        case cast(String.upcase(license)) do
          {:ok, license} ->
            insert(license)

          :error ->
            Mix.shell().error("you pass an invalid license")
            Mix.shell().info("you should pass 'mit,agpl, gpl, lgpl, mozilla, apache, boost'")
        end

      _ ->
        Mix.shell().info(
          "You have to pass --license flag and --verify if you can check all the files"
        )
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

  defp verify(license) do
    files = lib_files()

    license_id = ExLicense.spdx_id(license)

    if Enum.all?(files, &have_license_header?(&1, license_id)) do
      exit({:shutdown, 0})
    else
      Mix.shell().error("Files do not start with the license header")
      Mix.shell().info("Be sure to have a license header or run mix insert_license")
      exit({:shutdown, 1})
    end
  end

  defp insert(license) do
    files = lib_files()
    license_id = ExLicense.spdx_id(license)

    files
    |> Enum.reject(&have_license_header?(&1, license_id))
    |> Enum.each(&insert_license_header(&1, license_id))
  end

  defp lib_files do
    [File.cwd!(), "/lib/**/*.ex"]
    |> Path.join()
    |> Path.wildcard()
    |> Enum.reject(&String.contains?(&1, "lib/mix"))
  end

  defp have_license_header?(filename, license_id) do
    content = File.read!(filename)
    String.starts_with?(content, comment(license_id))
  end

  defp insert_license_header(filename, license_id) do
    content = File.read!(filename)
    File.write(filename, [comment(license_id), "\n", content])
  end

  defp comment(license_id) do
    "# SPDX-License-Identifier: #{license_id}"
  end
end
