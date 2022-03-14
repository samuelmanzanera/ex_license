defmodule ExLicense.SPDX do
  @moduledoc false

  @type available_license() ::
          :mit | :agpl_v3 | :gpl_v3 | :lgpl_v3 | :mozilla_v2 | :apache_v2 | :boost_v1

  @doc """
  Return the SPDX License identifier

  ## Examples

      iex> ExLicense.SPDX.id(:mit)
      "MIT"

      iex> ExLicense.SPDX.id(:agpl_v3)
      "AGPL-3.0-or-later"
  """
  @spec id(available_license()) :: String.t()
  def id(:mit), do: "MIT"
  def id(:agpl_v3), do: "AGPL-3.0-or-later"
  def id(:gpl_v3), do: "GPL-3.0+"
  def id(:lgpl_v3), do: "LGPL-3.0+"
  def id(:mozilla_v2), do: "MPL-2.0"
  def id(:apache_v2), do: "Apache-2.0"
  def id(:boost_v1), do: "BSL-1.0"

  @doc """
  Return the comment for the SPDX License header for the given license id
  """
  @spec comment(available_license()) :: String.t()
  def comment(spdx_id) do
    "# SPDX-License-Identifier: #{spdx_id}"
  end

  @doc """
  Returns the base comment of any SPDX License Identifier
  """
  @spec comment_base() :: String.t()
  def comment_base do
    "# SPDX-License-Identifier:"
  end
end
