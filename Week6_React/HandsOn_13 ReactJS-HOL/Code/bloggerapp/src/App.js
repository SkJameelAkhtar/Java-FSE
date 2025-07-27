import React, { useState } from 'react';
import BookDetails from './BookDetails';
import BlogDetails from './BlogDetails';
import CourseDetails from './CourseDetails';
import './App.css';

function App() {
  const [view, setView] = useState('books'); 

  const renderWithIfElse = () => {
    if (view === 'books') {
      return <BookDetails />;
    } else if (view === 'blogs') {
      return <BlogDetails />;
    } else if (view === 'courses') {
      return <CourseDetails />;
    }
  };

  let content;
  if (view === 'books') {
    content = <BookDetails />;
  } else if (view === 'blogs') {
    content = <BlogDetails />;
  } else {
    content = <CourseDetails />;
  }

  const componentMap = {
    books: <BookDetails />,
    blogs: <BlogDetails />,
    courses: <CourseDetails />,
  };

  return (
    <div className="App">
      <header>
        <h1>Blogger App</h1>
        <p>Showing components using different conditional rendering methods.</p>
        <nav>
          <button onClick={() => setView('books')}>Show Books</button>
          <button onClick={() => setView('blogs')}>Show Blogs</button>
          <button onClick={() => setView('courses')}>Show Courses</button>
        </nav>
      </header>

      <main>
        <section className="card">
          <h2>Rendered with If-Else</h2>
          {renderWithIfElse()}
        </section>

        <section className="card">
          <h2>Rendered with Ternary Operator</h2>
          {view === 'books' ? (
            <BookDetails />
          ) : view === 'blogs' ? (
            <BlogDetails />
          ) : (
            <CourseDetails />
          )}
        </section>

        <section className="card">
          <h2>Rendered with Logical && Operator</h2>
          {view === 'books' && <BookDetails />}
          {view === 'blogs' && <BlogDetails />}
          {view === 'courses' && <CourseDetails />}
        </section>

        <section className="card">
          <h2>Rendered with an Element Variable</h2>
          {content}
        </section>
        
        <section className="card">
            <h2>Rendered with Object Mapping</h2>
            {componentMap[view]}
        </section>
      </main>
    </div>
  );
}

export default App;