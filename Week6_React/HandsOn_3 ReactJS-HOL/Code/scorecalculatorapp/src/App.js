import './App.css';
import { CalculateScore } from './components/CalculateScore';

function App() {
  return (
    <div>
      <CalculateScore 
        Name = {"Jameel"}
        School = {"Vivekananda Mission School"}
        total = {284}
        goal = {3}
      />
    </div>
  );
}

export default App;