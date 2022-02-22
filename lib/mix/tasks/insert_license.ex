defmodule Mix.Tasks.InsertLicense do
  use Mix.Task

  @header """
  # SPDX-License-Identifier: AGPL-3.0-or-later
  """

  def run(["--verify"]) do
    files = lib_files()

    if Enum.all?(files, &have_license_header?/1) do
      exit({:shutdown, 0})
    else
      Mix.shell().error("Files do not start with the license header")
      Mix.shell().info("Be sure to have a license header or run mix insert_license")
      exit({:shutdown, 1})
    end
  end

  def run(_) do
    files = lib_files()

    files
    |> Enum.reject(&have_license_header?/1)
    |> Enum.each(&insert_license_header/1)
  end

  defp lib_files do
    [File.cwd!(), "/lib/**/*.ex"]
    |> Path.join()
    |> Path.wildcard()
    |> Enum.reject(&String.contains?(&1, "lib/mix"))
  end

  defp have_license_header?(filename) do
    content = File.read!(filename)
    String.starts_with?(content, @header)
  end

  defp insert_license_header(filename) do
    content = File.read!(filename)
    File.write(filename, [@header, "\n", content])
  end
end
