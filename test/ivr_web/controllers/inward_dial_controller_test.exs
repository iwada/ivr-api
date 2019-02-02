defmodule IvrWeb.InwardDialControllerTest do
  use IvrWeb.ConnCase

  alias Ivr.Telephony
  alias Ivr.Telephony.InwardDial

  @create_attrs %{
    direct_inward_dial_number: "some direct_inward_dial_number",
    status: true
  }
  @update_attrs %{
    direct_inward_dial_number: "some updated direct_inward_dial_number",
    status: false
  }
  @invalid_attrs %{direct_inward_dial_number: nil, status: nil}

  def fixture(:inward_dial) do
    {:ok, inward_dial} = Telephony.create_inward_dial(@create_attrs)
    inward_dial
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all inwarddials", %{conn: conn} do
      conn = get(conn, Routes.inward_dial_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create inward_dial" do
    test "renders inward_dial when data is valid", %{conn: conn} do
      conn = post(conn, Routes.inward_dial_path(conn, :create), inward_dial: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.inward_dial_path(conn, :show, id))

      assert %{
               "id" => id,
               "direct_inward_dial_number" => "some direct_inward_dial_number",
               "status" => true
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.inward_dial_path(conn, :create), inward_dial: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update inward_dial" do
    setup [:create_inward_dial]

    test "renders inward_dial when data is valid", %{conn: conn, inward_dial: %InwardDial{id: id} = inward_dial} do
      conn = put(conn, Routes.inward_dial_path(conn, :update, inward_dial), inward_dial: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.inward_dial_path(conn, :show, id))

      assert %{
               "id" => id,
               "direct_inward_dial_number" => "some updated direct_inward_dial_number",
               "status" => false
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, inward_dial: inward_dial} do
      conn = put(conn, Routes.inward_dial_path(conn, :update, inward_dial), inward_dial: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete inward_dial" do
    setup [:create_inward_dial]

    test "deletes chosen inward_dial", %{conn: conn, inward_dial: inward_dial} do
      conn = delete(conn, Routes.inward_dial_path(conn, :delete, inward_dial))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.inward_dial_path(conn, :show, inward_dial))
      end
    end
  end

  defp create_inward_dial(_) do
    inward_dial = fixture(:inward_dial)
    {:ok, inward_dial: inward_dial}
  end
end
