import React from 'react';

const FlightDetails = ({ showBookingButton }) => {
  const flights = [
    { id: 1, from: 'New York', to: 'London', price: '₹60,000' },
    { id: 2, from: 'Delhi', to: 'Paris', price: '₹55,000' },
    { id: 3, from: 'Tokyo', to: 'Sydney', price: '₹75,000' },
  ];

  return (
    <div className="flights-container">
      <h2>Available Flights</h2>
      {flights.map(flight => (
        <div key={flight.id} className="flight-card">
          <h3>{flight.from} to {flight.to}</h3>
          <p>Price: {flight.price}</p>
          {showBookingButton && (
            <button className="book-button" onClick={() => alert(`Booking flight from ${flight.from} to ${flight.to}`)}>
              Book Now
            </button>
          )}
        </div>
      ))}
    </div>
  );
};

export default FlightDetails;