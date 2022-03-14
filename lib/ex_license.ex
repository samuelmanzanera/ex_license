defmodule ExLicense do
  @moduledoc """
  Documentation for `ExLicense`.
  """

  alias __MODULE__.SPDX

  @doc """
  Insert the header with corresponding license
  """
  @spec insert_header(SPDX.available_license()) :: :ok
  def insert_header(license) do
    files = lib_files()
    license_id = SPDX.id(license)

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
    if String.starts_with?(content, SPDX.comment_base()) do
      if !String.starts_with?(content, SPDX.comment(license_id)) do
        IO.warn "Different SPDX License header in #{filename}"
      end
      true
    else
      false
    end
  end

  defp insert_license_header(filename, license_id) do
    content = File.read!(filename)
    File.write(filename, [SPDX.comment(license_id), "\n", content])
  end

  @doc """
  Determine if the files have the license header for the given license
  """
  @spec with_header?(SPDX.available_license()) :: boolean()
  def with_header?(license) do
    files = lib_files()
    license_id = SPDX.id(license)
    Enum.all?(files, &have_license_header?(&1, license_id))
  end
end
