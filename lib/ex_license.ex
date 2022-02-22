defmodule ExLicense do
  @moduledoc """
  Documentation for `ExLicense`.
  """

  @type available_license() ::
          :mit | :agpl_v3 | :gpl_v3 | :lgpl_v3 | :mozilla_v2 | :apache_v2 | :boost_v1

  @doc """
  Return the SPDX License identifier
  """
  @spec spdx_id(available_license()) :: String.t()
  def spdx_id(:mit), do: "MIT"
  def spdx_id(:agpl_v3), do: "AGPL-3.0-or-later"
  def spdx_id(:gpl_v3), do: "GPL-3.0+"
  def spdx_id(:lgpl_v3), do: "LGPL-3.0+"
  def spdx_id(:mozilla_v2), do: "MPL-2.0"
  def spdx_id(:apache_v2), do: "Apache-2.0"
  def spdx_id(:boost_v1), do: "BSL-1.0"
end
