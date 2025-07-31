import React from "react";

const ListofPlayers = () => {
  const players = [
    { name: "Rahul Dravid", score: 85 },
    { name: "MS Dhoni", score: 65 },
    { name: "Ben Stokes", score: 92 },
    { name: "Starc", score: 58 },
    { name: "Ashwin", score: 71 },
    { name: "Sachin", score: 45 },
    { name: "Joe Root", score: 79 },
    { name: "Umesh", score: 88 },
    { name: "Chahal", score: 60 },
    { name: "AB Develliers", score: 75 },
    { name: "Kane", score: 95 },
  ];

  const playersBelow70 = players.filter((player) => player.score < 70);

  return (
    <div>
      <h2>All Players</h2>
      <ul>
        {players.map((player, index) => (
          <li key={index}>
            {player.name} - Score: {player.score}
          </li>
        ))}
      </ul>
      <h2>Players with Scores Below 70</h2>
      <ul>
        {playersBelow70.map((player, index) => (
          <li key={index}>
            {player.name} - Score: {player.score}
          </li>
        ))}
      </ul>
      <hr />
    </div>
  );
};

export default ListofPlayers;
