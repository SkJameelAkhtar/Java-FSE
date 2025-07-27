import React, { useState } from "react";

import CurrencyConvertor from "./CurrencyConvertor";
import "./App.css";
function App() {
  const [count, setCount] = useState(0);

  const incrementValue = () => {
    setCount((prevCount) => prevCount + 1);
  };
  const sayHello = () => {
    alert("Hello! This is the method called on increment.");
  };

  const handleIncrement = () => {
    incrementValue();
    sayHello();
  };

  const handleDecrement = () => {
    setCount((prevCount) => prevCount - 1);
  };

  const showMessage = (message) => {
    alert(message);
  };

  const handlePress = (e) => {
    console.log(e);
    alert("I was clicked");
  };
  return (
    <div className="App">
      <h1>React Event Examples</h1>

      <div className="card">
        <h2>Counter</h2>
        <p className="counter-display">Current Value: {count}</p>
        <button onClick={handleIncrement} className="action-button">
          Increment
        </button>
        <button onClick={handleDecrement} className="action-button-secondary">
          Decrement
        </button>
      </div>

      <div className="card">
        <h2>Other Event Handlers</h2>
        <button
          onClick={() => showMessage("Welcome")}
          className="action-button"
        >
          Say Welcome
        </button>

        <button onClick={handlePress} className="action-button">
          OnPress (Synthetic Event)
        </button>
      </div>

      <div className="card">
        <CurrencyConvertor />
      </div>
    </div>
  );
}
export default App;
