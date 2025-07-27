import logo from "./logo.svg";
import "./App.css";
import { Home } from "./components/Home";
import { Contact } from "./components/Contact";
import { About } from "./components/About";

function App() {
  return (
    <div className="container">
      <Home />
      <Contact />
      <About />
    </div>
  );
}

export default App;
