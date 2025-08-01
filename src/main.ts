import { Elm } from "./Main.elm";

const basePath = import.meta.env.BASE_URL;
const node = document.getElementById("app");
const {
  ports: {
    interopToElm: { send },
    interopFromElm: { subscribe },
  },
} = Elm.Main.init({
  node,
  flags: {
    basePath,
  },
});

subscribe((m) => {
  switch (m.tag) {
    case "ElmReady":
      return send({ tag: "JSReady" });
    default:
      throw Error("Unrecognized message");
  }
});
