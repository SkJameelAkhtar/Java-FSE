import React from 'react';
import './App.css';
import officeImage from './office-space.webp'; // Make sure you have an image file here

function App() {
  const pageTitle = <h1>Office Space Rentals</h1>;

  const officeImageElement = <img src={officeImage} alt="Modern office space" className="office-image" width={200} height={200}/>;

  const primaryOffice = {
    name: 'Sunrise Towers',
    rent: 75000,
    address: '123 Business Rd, Metropolis'
  };

  const officeSpaces = [
    { id: 1, name: 'Innovate Hub', rent: 55000, address: '456 Tech Park, Silicon Valley' },
    { id: 2, name: 'Corporate Gateway', rent: 82000, address: '789 Enterprise Ave, New York' },
    { id: 3, name: 'The Business Center', rent: 48000, address: '101 Commerce St, Chicago' }
  ];

  const getRentStyle = (rent) => {
    return {
      color: rent < 60000 ? 'red' : 'green',
      fontWeight: 'bold'
    };
  };

  return (
    <div className="App">
      {pageTitle}
      
      <div className="office-card">
        <h2>Featured Office</h2>
        {officeImageElement}
        <h3>{primaryOffice.name}</h3>
        <p>
          <strong>Rent: </strong>
          <span style={getRentStyle(primaryOffice.rent)}>
            ₹{primaryOffice.rent.toLocaleString()} / month
          </span>
        </p>
        <p><strong>Address:</strong> {primaryOffice.address}</p>
      </div>
      
      <hr />
      
      <h2>Available Spaces</h2>
      <div className="office-list">
        {officeSpaces.map((office) => (
          <div key={office.id} className="office-card">
            <h3>{office.name}</h3>
            <p>
              <strong>Rent: </strong>
              <span style={getRentStyle(office.rent)}>
                ₹{office.rent.toLocaleString()} / month
              </span>
            </p>
            <p><strong>Address:</strong> {office.address}</p>
          </div>
        ))}
      </div>
    </div>
  );
}

export default App;