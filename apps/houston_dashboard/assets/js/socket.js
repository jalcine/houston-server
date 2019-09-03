// To use Phoenix channels, the first step is to import Socket,
// and connect at the socket path in "lib/web/endpoint.ex".
//
// Pass the token on params as below. Or remove it
// from the params if you are not using authentication.
import LiveSocket from "phoenix_live_view"

let liveSocket = new LiveSocket("/live", { params: { token: window.userToken } })

liveSocket.connect()
