defmodule ExSentry.Session do
  require Record
  Record.defrecord :session sid: "", data: %{}, timestamp: erlang.now()
  @type session :: record(:session, sid: String.t, data: map, timestamp: erlang.timestamp)


end
