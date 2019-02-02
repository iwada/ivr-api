defmodule IvrWeb.InwardDialView do
  use IvrWeb, :view
  alias IvrWeb.InwardDialView

  def render("index.json", %{inwarddials: inwarddials}) do
    %{data: render_many(inwarddials, InwardDialView, "inward_dial.json")}
  end

  def render("show.json", %{inward_dial: inward_dial}) do
    %{data: render_one(inward_dial, InwardDialView, "inward_dial.json")}
  end

  def render("inward_dial.json", %{inward_dial: inward_dial}) do
    %{id: inward_dial.id,
      direct_inward_dial_number: inward_dial.direct_inward_dial_number,
      status: inward_dial.status}
  end
end
