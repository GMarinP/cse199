const myWasm = "mygame.wasm";
const myPck = "mygame.pck";
const engine = new Engine();
Promise.all([
  // Load and init the engine
  engine.init(myWasm),
  // And the pck concurrently
  engine.preloadFile(myPck),
])
  .then(() => {
    // Now start the engine.
    return engine.start({ args: ["--main-pack", myPck] });
  })
  .then(() => {
    console.log("Engine has started!");
  });
