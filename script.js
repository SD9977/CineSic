document.addEventListener('DOMContentLoaded', () => {
  loadMovies();
  loadSongs();
});

// Movies as cards
function loadMovies() {
  const movies = [
    { title: "Inception", year: "2010", genre: "Sci-Fi", language: "English" },
    { title: "RRR", year: "2022", genre: "Action", language: "Telugu" }
  ];
  const list = document.getElementById('movieList');
  list.innerHTML = movies.map(m => `
    <div class="card">
      <p>${m.title} (${m.year}) - ${m.genre} [${m.language}]</p>
    </div>
  `).join('');
}

// Songs as cards
function loadSongs() {
  const songs = [
    { title: "Shape of You", artist: "Ed Sheeran", genre: "Pop", language: "English" },
    { title: "Tum Hi Ho", artist: "Arijit Singh", genre: "Romance", language: "Hindi" }
  ];
  const list = document.getElementById('songList');
  list.innerHTML = songs.map(s => `
    <div class="card">
      <p>${s.title} - ${s.artist} (${s.genre}) [${s.language}]</p>
    </div>
  `).join('');
}

// Search functionality for cards
document.getElementById('searchBar').addEventListener('input', function() {
  const query = this.value.toLowerCase();
  document.querySelectorAll('.card').forEach(card => {
    const text = card.querySelector('p') ? card.querySelector('p').innerText.toLowerCase() : "";
    card.style.display = text.includes(query) ? '' : 'none';
  });
});
