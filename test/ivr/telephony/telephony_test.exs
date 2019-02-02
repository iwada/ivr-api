defmodule Ivr.TelephonyTest do
  use Ivr.DataCase

  alias Ivr.Telephony

  describe "events" do
    alias Ivr.Telephony.Event

    @valid_attrs %{confidence: "some confidence", host: "some host", index: "some index", sipcallid: "some sipcallid", source: "some source", time: "some time", transcription: "some transcription"}
    @update_attrs %{confidence: "some updated confidence", host: "some updated host", index: "some updated index", sipcallid: "some updated sipcallid", source: "some updated source", time: "some updated time", transcription: "some updated transcription"}
    @invalid_attrs %{confidence: nil, host: nil, index: nil, sipcallid: nil, source: nil, time: nil, transcription: nil}

    def event_fixture(attrs \\ %{}) do
      {:ok, event} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Telephony.create_event()

      event
    end

    test "list_events/0 returns all events" do
      event = event_fixture()
      assert Telephony.list_events() == [event]
    end

    test "get_event!/1 returns the event with given id" do
      event = event_fixture()
      assert Telephony.get_event!(event.id) == event
    end

    test "create_event/1 with valid data creates a event" do
      assert {:ok, %Event{} = event} = Telephony.create_event(@valid_attrs)
      assert event.confidence == "some confidence"
      assert event.host == "some host"
      assert event.index == "some index"
      assert event.sipcallid == "some sipcallid"
      assert event.source == "some source"
      assert event.time == "some time"
      assert event.transcription == "some transcription"
    end

    test "create_event/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Telephony.create_event(@invalid_attrs)
    end

    test "update_event/2 with valid data updates the event" do
      event = event_fixture()
      assert {:ok, %Event{} = event} = Telephony.update_event(event, @update_attrs)
      assert event.confidence == "some updated confidence"
      assert event.host == "some updated host"
      assert event.index == "some updated index"
      assert event.sipcallid == "some updated sipcallid"
      assert event.source == "some updated source"
      assert event.time == "some updated time"
      assert event.transcription == "some updated transcription"
    end

    test "update_event/2 with invalid data returns error changeset" do
      event = event_fixture()
      assert {:error, %Ecto.Changeset{}} = Telephony.update_event(event, @invalid_attrs)
      assert event == Telephony.get_event!(event.id)
    end

    test "delete_event/1 deletes the event" do
      event = event_fixture()
      assert {:ok, %Event{}} = Telephony.delete_event(event)
      assert_raise Ecto.NoResultsError, fn -> Telephony.get_event!(event.id) end
    end

    test "change_event/1 returns a event changeset" do
      event = event_fixture()
      assert %Ecto.Changeset{} = Telephony.change_event(event)
    end
  end

  describe "inwarddials" do
    alias Ivr.Telephony.InwardDial

    @valid_attrs %{direct_inward_dial_number: "some direct_inward_dial_number", status: true}
    @update_attrs %{direct_inward_dial_number: "some updated direct_inward_dial_number", status: false}
    @invalid_attrs %{direct_inward_dial_number: nil, status: nil}

    def inward_dial_fixture(attrs \\ %{}) do
      {:ok, inward_dial} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Telephony.create_inward_dial()

      inward_dial
    end

    test "list_inwarddials/0 returns all inwarddials" do
      inward_dial = inward_dial_fixture()
      assert Telephony.list_inwarddials() == [inward_dial]
    end

    test "get_inward_dial!/1 returns the inward_dial with given id" do
      inward_dial = inward_dial_fixture()
      assert Telephony.get_inward_dial!(inward_dial.id) == inward_dial
    end

    test "create_inward_dial/1 with valid data creates a inward_dial" do
      assert {:ok, %InwardDial{} = inward_dial} = Telephony.create_inward_dial(@valid_attrs)
      assert inward_dial.direct_inward_dial_number == "some direct_inward_dial_number"
      assert inward_dial.status == true
    end

    test "create_inward_dial/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Telephony.create_inward_dial(@invalid_attrs)
    end

    test "update_inward_dial/2 with valid data updates the inward_dial" do
      inward_dial = inward_dial_fixture()
      assert {:ok, %InwardDial{} = inward_dial} = Telephony.update_inward_dial(inward_dial, @update_attrs)
      assert inward_dial.direct_inward_dial_number == "some updated direct_inward_dial_number"
      assert inward_dial.status == false
    end

    test "update_inward_dial/2 with invalid data returns error changeset" do
      inward_dial = inward_dial_fixture()
      assert {:error, %Ecto.Changeset{}} = Telephony.update_inward_dial(inward_dial, @invalid_attrs)
      assert inward_dial == Telephony.get_inward_dial!(inward_dial.id)
    end

    test "delete_inward_dial/1 deletes the inward_dial" do
      inward_dial = inward_dial_fixture()
      assert {:ok, %InwardDial{}} = Telephony.delete_inward_dial(inward_dial)
      assert_raise Ecto.NoResultsError, fn -> Telephony.get_inward_dial!(inward_dial.id) end
    end

    test "change_inward_dial/1 returns a inward_dial changeset" do
      inward_dial = inward_dial_fixture()
      assert %Ecto.Changeset{} = Telephony.change_inward_dial(inward_dial)
    end
  end
end
