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
end
