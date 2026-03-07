CREATE TABLE IF NOT EXISTS courses (
    id SERIAL PRIMARY KEY,
    name VARCHAR(200),
    docker_ready BOOLEAN DEFAULT true
);

INSERT INTO courses (name, docker_ready) VALUES
    ('Docker Basics', true),
    ('Docker Compose', true),
    ('Kubernetes', false);

CREATE TABLE IF NOT EXISTS students (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    progress INT
);

INSERT INTO students (name, progress) VALUES
    ('Max', 50),
    ('Anna', 75),
    ('Sergey', 100);
EOF