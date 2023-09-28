defmodule ChartsWeb.PageLive.Index do
  use ChartsWeb, :live_view

  # add points list to assigns
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:points, [14, 3, 8, 2, 6])}
  end

  def handle_params(_unsigned_params, _url, socket) do
    {:noreply, socket}
  end

  # store the points in data-points attribute that is serialized
  def render(assigns) do
    ~H"""
    <div>
      <h1>DATA</h1>
      <canvas id="my-chart" phx-hook="ChartJS" data-points={Jason.encode!(@points)}></canvas>
      <div class="flex flex-row justify-center gap-4">
        <.button phx-click="change-data" phx-value-set="1">SET 1</.button>
        <.button phx-click="change-data" phx-value-set="2">SET 2</.button>
        <.button phx-click="change-data" phx-value-set="3">SET 3</.button>
      </div>
    </div>
    """
  end

  def handle_event("change-data", %{"set" => set}, socket) do
    dataset =
      case set do
        "1" -> [2, 4, 6, 8, 10]
        "2" -> [10, 2, 9, 18, 11]
        _ -> [5, 14, 13, 22, 9]
      end

    {:noreply,
     socket
     |> push_event("update-points", %{points: dataset})}
  end
end
