defmodule ExSentry.Store do

  @behaviour Plug.Session.Store

  alias Plug.Session.Store, as: PlugStore

  def init(opts) do
    PlugStore.init
  end

  def get(_conn, sid, table) do

    # put mnesia here
    case :ets.lookup(table, sid) do
      [{^sid, data, _timestamp}] ->
        :ets.update_element(table, sid, {3, now()})
        {sid, data}
      [] ->
        {nil, %{}}
    end

  end

  def put(_conn, nil, data, table) do
    put_new(data, table)
  end

  def put(_conn, sid, data, table) do
    #replace with mnesia
    :ets.insert(table, {sid, data, now()})
    sid
  end

  def delete(_conn, sid, table) do
    #replace with mnesia
    :ets.delete(table, sid)
    :ok
  end

  defp put_new(data, table, counter \\ 0) when counter < @max_tries do
    sid = :crypto.strong_rand_bytes(96) |> Base.encode64

    # replace with mnesia
    if :ets.insert_new(table, {sid, data, now()}) do
      sid
    else
      put_new(data, table, counter + 1)
    end
  end

  defp now() do
    :os.timestamp()
  end
end
