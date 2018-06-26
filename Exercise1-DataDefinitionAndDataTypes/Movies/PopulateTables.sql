INSERT INTO Directors (DirectorName, Notes) VALUES
('Bash Director', 'GoAT!'),
('First son of Bash Director', 'Not so great...'),
('Second son of Bash Director', 'Somewhat better than his brother.'),
('Wannabe Director', 'Utter failure.'),
('Forgotten Director', NULL)

INSERT INTO Genres (GenreName, Notes) VALUES
('Action', 'Runnin'' & Gunnin'''),
('Biographical', 'The story of someone''s life'),
('Comedy', 'LoLs'),
('Drama', 'Opra.'),
('Horror', ':-@')

INSERT INTO Categories (CategoryName, Notes) VALUES
('GG', 'Gosh golly, that''s a good movie you got there!'),
('AD', 'Adultery and whatnot.'),
('CC-13', 'For sissies and wussies who stopped growing at the age of 13.'),
('W-4', 'Must be watched at least four times to understand the plot.'),
('Uncategorizable', 'When it doesn''t fit anywhere else...')

INSERT INTO Movies (Title, DirectorId, CopyrightYear, [Length], GenreId, CategoryId, Rating, Notes) VALUES
('Movie1', 5, 1951, '02:47:36', 2, 4, 0, NULL),
('Movie2', 4, 1972, '02:47:36', 3, 1, 9.5, NULL),
('Movie3', 3, 1993, '02:47:36', 1, 5, 8.8, NULL),
('Movie4', 2, 2014, '02:47:36', 4, 2, 6.9, NULL),
('Movie5', 1, 2035, '12:34:56', 5, 3, NULL, NULL)
