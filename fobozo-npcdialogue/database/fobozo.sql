CREATE TABLE IF NOT EXISTS npc_reputation (
    id INT AUTO_INCREMENT PRIMARY KEY,
    identifier VARCHAR(50) NOT NULL,
    ped_model VARCHAR(50) NOT NULL,
    reputation INT DEFAULT 0,
    UNIQUE (identifier, ped_model)
);
