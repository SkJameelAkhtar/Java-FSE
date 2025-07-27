import React from "react";

const IndianPlayers = () => {
  const allPlayers = [
    "Rahul Dravid",
    "MS Dhoni",
    "Balaji",
    "Anil Kumble",
    "Sachin Tendulkar",
    "Sourav Ganguly",
  ];
  const [oddPlayer, evenPlayer] = allPlayers;

  const T20players = ["Player 6", "Player 7"];
  const RanjiTrophyplayers = ["Player 8", "Player 9"];
  const mergedPlayers = [...T20players, ...RanjiTrophyplayers];

  return (
    <div>
      <h2>Indian Players</h2>
      <h3>Odd and Even Team Players (Destructuring)</h3>
      <p>Odd Team Player: {oddPlayer}</p>
      <p>Even Team Player: {evenPlayer}</p>
      <h3>Merged T20 and Ranji Trophy Players</h3>
      <ul>
        {mergedPlayers.map((player, index) => (
          <li key={index}>{player}</li>
        ))}
      </ul>
      <hr/>
    </div>
  );
};

export default IndianPlayers;
