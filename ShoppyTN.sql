CREATE DATABASE ShoppyTN;

CREATE TABLE users (
    id varchar(255) NOT NULL PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL UNIQUE,
	profile_pic Varchar(255) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    type VARCHAR(5) NOT NULL DEFAULT 'user',
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
);

CREATE TABLE products (
        id varchar(255) NOT NULL PRIMARY KEY,
        name VARCHAR(255) NOT NULL UNIQUE,
        description TEXT NOT NULL,
        image VARCHAR(255) NOT NULL UNIQUE,
        categorie VARCHAR(255) NOT NULL,
        price VARCHAR(20) NOT NULL,
        stock INTEGER NOT NULL,
        stars_count INTEGER NOT NULL,
        stars_sum DECIMAL(10,2) NOT NULL,
        stars DECIMAL(2,1) NOT NULL DEFAULT 0.00;
        created_at TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
);


CREATE TABLE cart_items (
        id varchar(255) NOT NULL PRIMARY KEY,
        user_id INTEGER NOT NULL,
        product_id INTEGER NOT NULL,
        quantity INTEGER NOT NULL,
        created_at TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
        FOREIGN KEY(user_id) REFERENCES users (id) on update cascade on delete cascade
        FOREIGN KEY(product_id) REFERENCES products (id) on update cascade on delete cascade
);

ALTER TABLE users
ADD CONSTRAINT CHECK(type = "user" OR type = "admin" );

INSERT INTO `products` (`id`, `name`, `description`, `image`, `categorie`, `price`, `stock`, `stars_count`, `stars_sum`, `stars`, `created_at`) VALUES
	('1437449871', 'PC DE BUREAU GAMER MYTEK I5 10ÃƒÂˆ GÃ©N 8GO GTX 1650 VENTUS XS OC', 'Processeur: Intel Core i5-10400F (2,90 GHz up to 4,30 GHz Turbo max, 12Mo MÃ©moire cache, Hexa-Core) - SystÃ¨me d\'exploitation: FreeDos - MÃ©moire RAM: 8G DDR4 PATRIOT V4S - Disque Dur: TEAM GROUP CX2 SSD 2.5" 256 Go - Carte mÃ¨re: MSI H510M-A-PRO Micro-ATX - Carte graphique: MSI GEFORCE GTX 1650 VENTUS XS OC (4 Go de mÃ©moire dÃ©diÃ©e DDR6) - BoÃƒÂ®tier XIGMATEK NYX 3: Mini Tour 3x ventilateur RGB avant - BoÃƒÂ®te d\'alimentation: NJOY TITAN+ 500W 80+ BRONZE - Dimensions: 325 x 205 x 398 mm - Couleur: Noir - Garantie: 1 an', '/files/search_images/PCs_bureau/kitana-i5-1650-v2-a.jpg', 'PCs_bureau', '1,599', 118, 452, 2652.08, 5.9, '2024-05-23 18:58:31'),
	('2229224147', 'Ã©COUTEUR SANS FIL LENOVO LIVE PODS XT91 - NOIR', 'Ã©couteur sans fil LENOVO Live Pods XT91 - Technologie de connectivitÃ©: Bluetooth 5.0 - PortÃ©e de transmission: 10 m - Avec la technologie TWS - CapacitÃ© de la batterie: Batterie des Ã©couteurs(chacun): 40 mAh - Batterie de la bouate de chargement: 300 mAh - environ 3 heures de temps de quran - Controle tactile intelligent - Avec affichage numÃ©rique de la consommation de la batterie - Couleur: Noir - Garantie: 1an', '/files/search_images/kit/1652956896386_104_1.jpg', 'kit', '89', 936, 971, 3925.79, 4.0, '2024-05-23 18:58:32'),
	('2690444601', 'Smartphone ONEPLUS Nord 2 5G 8Go 128Go - Gris', 'Ã©cran 6.43" FHD HDR10+ Fluid AMOLED 90 Hz (2400 x 1080 Pixels), Gorilla Glass 5 - Processeur: MediaTek MT6893 Dimensity 1200 5G, Octa-core (1x3.0 GHz Cortex-A78 & 3x2.6 GHz Cortex-A78 & 4x2.0 GHz Cortex-A55), Mali-G77 MC9 - SystÃ©me d\'exploitation: OxygenOS 11.3 basÃ© sur Android 11 - MÃ©moire RAM: 8Go - Stockage: 128Go - Appareil Photo ArriÃ©re: 50MP (f/1.9, 24mm (wide), 1/1.56 , 1.0ÃƒÂ‚Ã‚Âµm, PDAF, OIS) + 8MP (f/2.3, 119ÃƒÂ‹Ã…Â¡ (ultrawide)) + 2MP (f/2.4, (monochrome)) Dual-LED flash, HDR, panorama, 4K@30fps, 1080p@30/60/240fps, gyro-EIS , Frontale: 32 MP (f/2.5, (wide), 1/2.8 , 0.8ÃƒÂ‚Ã‚Âµm) Auto HDR 1080p@30fps, gyro-EIS - Empreinte digitale - NFC - ConnectivitÃ©: 5G, Wifi et Bluetooth 5.2 - Batterie: 4500 mAh - Charge rapide 65W - 1-100% en 30 min - Couleur: Gris - Garantie: 1 an', '/files/search_images/phones/010-02159-14_1544_1.jpg', 'phones', '1,249', 86, 347, 1471.29, 4.2, '2024-05-23 18:58:30'),
	('2763409317', 'PC PORTABLE ASUS VIVOBOOK 15 AMD RYZEN 7 8GO 512GO SSD - ICELIGHT SILVER', 'Ã©cran 15.6" Full HD, IPS - Processeur: AMD Ryzen 7 4800H (2.9 GHz up to 4.2 GHz Turbo max, L2: 4Mo / L3: 8 Mo de mÃ©moire cache, Octa-Core) - SystÃ¨me d\'exploitation: Windows 11 Famille - MÃ©moire RAM: 8 Go - Disque Dur: 512 Go SSD - Carte Graphique: AMD Radeon Graphics avec Wi-Fi, Bluetooth, 1x USB 2.0 Type-A, 1x USB 3.2 Gen 1 Type-C, 2x USB 3.2 Gen 1 Type-A, 1x HDMI 1.4, 1x Prise audio combinÃ©e 3,5 mm, 1x EntrÃ©e CC - Clavier Chiclet avec touche numÃ©rique - Capteur d\'empreintes digitales - Couleur: Icelight Silver - Garantie: 1 an', '/files/search_images/PCs/m1502ia-bq315w_1.jpg', 'PCs', '1,699', 684, 100, 741.52, 7.4, '2024-05-23 18:58:32'),
	('3274185560', 'PC DE BUREAU GAMER LENOVO LÃ©GION T5 26IOB6 I7 11ÃƒÂˆ GÃ©N 32GO RTX 3070', 'Processeur: Intel Core i7-11700 (2,50 GHz up to 4,90 GHz Turbo max ,16Mo de MÃ©moire Cache, Octa-Core) - SystÃ¨me d\'exploitation: FreeDos - MÃ©moire RAM: 32 Go DDR4-3200 - Disque Dur: 1 To SSD - Carte Graphique: NVIDIA GeForce RTX 3070 (8Go de mÃ©moire dÃ©diÃ©e GDDR6) avec Wi-Fi, Bluetooth, 4x USB 3.2 Gen 1, 2xUSB 2.0, 1x USB-C 3.2 Gen 2, 1xRJ-45, 1x casque (3,5 mm), 1x microphone (3,5 mm) et 3x sortie audio - Couleur: Noir - Garantie: 2 ans', '/files/search_images/PCs_bureau/90rt00frfe-24g-10_1_1.jpg', 'PCs_bureau', '5,209', 552, 663, 4778.86, 7.2, '2024-05-23 18:58:31'),
	('3430673785', 'IPHONE 13 PRO MAX 256GO VERT - APPLE', 'Ecran 6,7 OLED Super Retina XDR HDR - RÃ©solution: 2778 x 1284 pixels Ã  458 ppp - Processeur: Puce A15 Bionic (5 nm) Hexa-core ( 2x3.22 GHz Avalanche + 4xX.X GHz Blizzard) - GPU Graphics Apple 5 Coeurs - SystÃ¨me d\'exploitation: iOS 15 - MÃ©moire RAM: 6 Go - Stockage: 256Go - Appareil photo ArriÃ¨re: Trio Pixels: 12 MÃ©gaPixels TÃ©lÃ©objectif avec ouverture Ã†Â’/2,8 + 12 MÃ©gaPixels GrandÃ¢Â€Â‘angle avec ouverture Ã†Â’/1,5 + 12 MÃ©gaPixels Ultra grandÃ¢Â€Â‘angle avec ouverture Ã†Â’/1,8 et champ de vision de 120Ã‚Â° - Appareil Avant: 12 MÃ©gaPixels avec Ouverture Ã†Â’/2,2 - Video 4K HDR avec Wifi, RÃ©seau 5G , GPS , NFC et Bluetooth 5.0 - Batterie: Li-Ion 4352 mAh - Face ID - Couleur: vert - Garantie: 1 an', '/files/search_images/phones/1_2945.jpg', 'phones', '5,399', 662, 124, 834.60, 6.7, '2024-05-23 18:58:29'),
	('3432292479', 'PC DE BUREAU GAMER MYTEK AMD RYZEN 5 8GO 240GO SSD - NOIR', 'Processeur: AMD Ryzen 5 PRO 5650GE (3.4 GHz up to 4.4 GHz Turbo max, 16Mo MÃ©moire cache, Hexa-Core) - SystÃ¨me d\'exploitation: FreeDos - MÃ©moire RAM: Goodram 8Go DDR4 3200MHz - Disque Dur: GOODRAM Disque SSD 240Go SATA III - Refroidisseur CPU : AMD Wraith Stealth - Carte mÃ¨re: ASUS PRIME A520M-K - Boitier SOG DEATHMATCH3 mini tower case x2 ARGB FANS 120mm with controller (M-ATX /ITX ONLY) - NJOY ALIMENTATION TITAN+ 500W 80+ BRONZE 80+ Active PFC/FLAT CABLES/SMART FAN CONTROL/LOW NOISE - Dimensions: 358 x175 x 333 mm - Couleur: Noir - Garantie: 1 an', '/files/search_images/PCs_bureau/jax-ryzen5--8_1.jpg', 'PCs_bureau', '1,359', 907, 997, 9715.60, 9.7, '2024-05-23 18:58:31'),
	('3688434641', 'IPHONE 13 256GO BLEU - APPLE', 'Ã©cran 6,1 OLED Super Retina XDR HDR - RÃ©solution: 2532 x 1170 pixels Ã  460 ppp - Processeur:  Puce A15 Bionic (5 nm) Hexa-core ( 2 x 3.22 GHz Avalanche + 4 x X.X GHz Blizzard) - GPU Graphics Apple 4 Coeurs - SystÃ¨me d\'exploitation: iOS 15 - MÃ©moire RAM: 4 Go - Stockage: 256Go - Appareil photo ArriÃ¨re: Dual Pixels: 12 MÃ©gaPixels avec ouverture Ã†Â’/1,6 + 12 MÃ©gaPixels Ultra grandÃ¢Â€Â‘angle avec ouverture Ã†Â’/2,4 et champ de vision de 120Ã‚Â° - Appareil Avant: 12 MÃ©gaPixels avec Ouverture Ã†Â’/2,2 - Video 4K HDR avec Wifi, RÃ©seau 5G , GPS , NFC et Bluetooth 5.0 - Batterie: Li-Ion 3240 mAh - Face ID - Couleur: Bleu - Garantie: 1 an', '/files/search_images/phones/1_2938.jpg', 'phones', '3,999', 727, 247, 793.45, 3.2, '2024-05-23 18:58:30'),
	('3717582895', 'TV TELEFUNKEN 32\'\' D22 HD AVEC RÃ©CEPTEUR INTÃ©GRÃ©', 'Tv TELEFUNKEN 32 D22 HD Avec RÃ©cepteur intÃ©grÃ© - RÃ©solution: 1366 x 768 pixels - LuminositÃ©: 200 cd / mÃ‚Â² - App prÃ©installÃ©e: minuterie d\'arrÃƒÂªt - Fonctions: Liste des chaÃƒÂ®nes, Liste des chaÃƒÂ®nes prÃ©fÃ©rÃ©es, Ã©diteur de chaÃƒÂ®nes - Sortie audio : 2 x 8 W - avec TNT - Connecteurs: 2x HDMI, 2 x USB, Sortie audio 3.5 mm - Dimensions: sans support 723.2 x 60.5 x 453.6 mm , avec support 723.2 x 200.4 x 467.5 mm - Couleur: Noir - Garantie: 3 ans', '/files/search_images/TVs/1_1980.jpg', 'TVs', '399', 116, 696, 2444.75, 3.5, '2024-05-23 18:58:30'),
	('3891306109', 'Smartphone INFINIX Note 11 Pro 8Go 128Go - Vert', 'Ã©cran 6.95" LCD FHD IPS (1080x 2460pixels),120Hz - Processeur: Mediatek Helio G96 Octa-Core (2.05 GHZ) - SystÃ©me d\'exploitation: Android 11, XOS 10 - MÃ©moire  RAM: 8 Go - Stockage: 128 Go - Appareil Photo ArriÃ©re: 64MP x30 Zoom tÃ©lescopique + 13MP + 2MP , Quad-LED flash, HDR, panorama, 1440p@30fps - Appareil Photo Frontale 16MP, 1080p@30fps - ConnectivitÃ©: Wifi 4G et Bluetooth 5.0 - Batterie: Li-Po 5000 mAh - Charge Rapide 33W - Capteur d\'empreinte Digitale, DÃ©verrouillage du visage - Double SIM - Couleur: Vert - Garantie: 1an', '/files/search_images/phones/010-02159-14_1358_1.jpg', 'phones', '849', 514, 946, 7157.18, 7.6, '2024-05-23 18:58:30'),
	('4056648839', 'IPHONE 12 64GO VERT - APPLE', 'Ecran 6,1  Super Retina XDR OLED- RÃ©solution: 1170 x 2532 pixels - Processeur: Apple A14 Bionic (5 nm) Hexa-core (2x3.1 GHz Firestorm + 4x1.8 GHz Icestorm) GPU Apple GPU (4-core graphics) - SystÃ©me d\'exploitation: iOS - MÃ©moire RAM: 4 Go - Stockage: 64Go - Appareil photo Arriere Double: 12 MÃ©gaPixels  f/1.6 + 12 MÃ©gaPixels f/2.4 - Appareil Avant 12 MÃ©gaPixels f/2.2 avec Wifi, 4G et Bluetooth 5.0 - Batterie: Li-Ion 2815 mAh - RÃ©sistance Ã  l\'eau - Couleur: Vert - Garantie: 1 an', '/files/search_images/phones/1_2946.jpg', 'phones', '2,839', 473, 531, 847.88, 1.6, '2024-05-23 18:58:30'),
	('4298454740', 'IMPRIMANTE Ã  RÃ©SERVOIR INTÃ©GRÃ© 3EN1 HP INK TANK 315 COULEUR + CADEAU', 'Imprimante Ã  RÃ©servoir intÃ©grÃ© HP Ink Tank 315 - Fonctions: Impression, copier, NumÃ©risation - Format Papier: A4 - Technologie d\'impression: jet d\'encre thermique HP - Vitesse d\'impression: Jusqu\'Ã  19 ppm (Noir), Jusqu\'Ã  15 ppm (couleur) - RÃ©solution d\'impression: 1200 x 1200 dpi(couleur), 4800 x 1200 dpi(noir) - Vitesse de copie(A4, ISO): 6,5 cpm Noir; 2 cpm Couleur - Vitesse de numÃ©risation A4: Jusqu\'Ã  21 secondes - Impression recto verso Manuelle - Formats de fichiers pour la numÃ©risation: JPEG, TIFF, PDF, BMP, PNG - Vitesse du processeur: 360 MHz - ConnectivitÃ©: USB  - Dimensions: 525 x 310 x 158 mm - Poids: 4,67 kg - Garantie: 1 an', '/files/search_images/print/bu-z4b04a.jpg', 'print', '419', 397, 283, 2499.96, 8.8, '2024-05-23 18:58:32'),
	('4385678202', 'SMARTPHONE HUAWEI NOVA 9 8GO 128GO NOIR + ABONNEMENT 12 MOIS GRATUIT', 'Ã©cran: 6.57" Full HD+ OLED - RÃ©solution: 1080x 2340 pixels - SystÃ©me d\'exploitation: EMUI 12 - Processeur: Qualcomm SM7325 Snapdragon 778G 4G (6 nm) Octa-Core (4x2,4 GHz Kryo 670 & 4x1,8 GHz Kryo 670), Adreno 642L - MÃ©moire RAM: 8 Go - Stockage: 128 Go - Appareil Photo ArriÃ©re: Quad 50 MP 4K + 8 MP + 2 MP + 2 MP, LED flash, HDR, panorama, Appareil Photo Frontale: 32 MP - ConnctivitÃ©: 4G, Wifi et Bluetooth - Capteur d\'empreinte digitale - NFC - Double SIM - Autonomie de Batterie: 4300 mAh - Charge rapide 66W - 100% en 38 minutes - Couleur: Noir - Garantie: 1 an', '/files/search_images/phones/1_2802.jpg', 'phones', '1,099', 618, 478, 4705.29, 9.8, '2024-05-23 18:58:30'),
	('4417087223', 'IPHONE 12 128GO BLEU - APPLE', 'Ecran 6,1  Super Retina XDR OLED- RÃ©solution: 1170 x 2532 pixels - Processeur: Apple A14 Bionic (5 nm) Hexa-core (2x3.1 GHz Firestorm + 4x1.8 GHz Icestorm) GPU Apple GPU (4-core graphics) - SystÃ©me d\'exploitation: iOS - MÃ©moire RAM: 4 Go - Stockage: 128Go - Appareil photo Arriere Double: 12 MÃ©gaPixels  f/1.6 + 12 MÃ©gaPixels f/2.4 - Appareil Avant 12 MÃ©gaPixels f/2.2 avec Wifi, 4G et Bluetooth 5.0 - Batterie: Li-Ion 2815 mAh - RÃ©sistance Ã  l\'eau - Couleur: Bleu - Garantie: 1 an', '/files/search_images/phones/1_2942.jpg', 'phones', '3,199', 178, 177, 371.48, 2.1, '2024-05-23 18:58:30'),
	('4679369090', 'IPHONE 13 256GO MIDNIGHT - APPLE', 'Ã©cran 6,1 OLED Super Retina XDR HDR - RÃ©solution: 2532 x 1170 pixels Ã  460 ppp - Processeur:  Puce A15 Bionic (5 nm) Hexa-core ( 2 x 3.22 GHz Avalanche + 4 x X.X GHz Blizzard) - GPU Graphics Apple 4 Coeurs - SystÃ¨me d\'exploitation: iOS 15 - MÃ©moire RAM: 4 Go - Stockage: 256Go - Appareil photo ArriÃ¨re: Dual Pixels: 12 MÃ©gaPixels avec ouverture Ã†Â’/1,6 + 12 MÃ©gaPixels Ultra grandÃ¢Â€Â‘angle avec ouverture Ã†Â’/2,4 et champ de vision de 120Ã‚Â° - Appareil Avant: 12 MÃ©gaPixels avec Ouverture Ã†Â’/2,2 - Video 4K HDR avec Wifi, RÃ©seau 5G , GPS , NFC et Bluetooth 5.0 - Batterie: Li-Ion 3240 mAh - Face ID - Couleur: Midnight - Garantie: 1 an', '/files/search_images/phones/1_2937.jpg', 'phones', '3,999', 78, 55, 378.80, 6.9, '2024-05-23 18:58:29'),
	('5214840262', 'MONTRE CONNECTÃ©E SAMSUNG GALAXY WATCH5 BT 40 MM - SILVER', 'Ã©cran 1,2\'\' Super AMOLED (396x396pixels) - Verre saphir rÃ©sistant au rayures - Processeur: Dual Core 1,18 GHz - SystÃ¨me d\'exploitation: Wear OS - MÃ©moire: 1,5 Go - Stockage interne: 16 Go - Batterie: 284mAh - Autonomie en utilisation typique: Jusqu\'Ã  40 heures - Batterie 13 % plus grande pour un usage quotidien, 30 minutes de charge pour 45% de batterie - Suivi du sommeil - Surveillance de la santÃ© et du bien-ÃƒÂƒÃ‚Âªtre 24h/24 - Capteur bioactif -  GPS,Glonass,Beidou,Galileo - NFC -  FonctionnalitÃ©s au quotidien notifications, SmartThings, Samsung Pay, Google Pay - ConnectivitÃ©: Wi-Fi 802.11 a/b/g/n 2.4+5GHz,Bluetooth 5.2 - Resistance Ã  l\'eau: IP68, 5ATM - prend en charge plus de 90 exercices - Bouatier aluminium - Dimensions: 39.3 x 40.4 x 9.8 mm - Poids: 28.7 g - Couleur: Silver', '/files/search_images/montre/1_2854.jpg', 'montre', '1,099', 835, 664, 2237.02, 3.4, '2024-05-23 18:58:32'),
	('5349806734', 'TV VEGA 43\'\' DLED FULL HD AVEC RÃ©CEPTEUR INTÃ©GRÃ© + SUPPORT MURAL + CÃƒÂ‚BLE HDMI', 'TV VEGA 43" DLED Full HD Avec RÃ©cepteur intÃ©grÃ© - RÃ©solution 1920 x 1080 pixels - Temps de rÃ©ponse: 8 ms - Contraste 3000:1 - Aspect ratio 16:9 - Dolby Plus SUROUND, DTS, DDX, DOLBY - Sortie Audio: 2 ÃƒÂ— 8W - Connecteurs: 2x HDMI, 1x USB, 1x Sortie Casque - Dimensions: 97 x 56.9 x 9 cm - Poids: 6.6Kg - Garantie: 3 ans', '/files/search_images/TVs/3_934.jpg', 'TVs', '679', 159, 348, 2300.65, 6.6, '2024-05-23 18:58:31'),
	('5468760155', 'SMARTPHONE HUAWEI NOVA Y90 6GO 128GO NOIR + ABONNEMENT 12MOIS', 'Ã©cran 6.7" LCD IPS (1080 x 2388 pixels), 90Hz - Processeur: Qualcomm SM6225 Snapdragon 680 4G (6 nm) Octa-core (4x2,4 GHz Kryo 265 Gold & 4x1,9 GHz Kryo 265 Silver) AdrÃ¨ne 610 - SystÃ©me d\'exploitation: EMUI 12 - MÃ©moire RAM: 6Go - Stockage: 128Go - Appareil Photo ArriÃ©re: Trio 50 MP, f/1.8, (large), PDAF, 2 MP, f/2.4, (macro), 2 MP, f/2.4, (profondeur) et Frontale: 8MP ouverture f/2.0- ConnctivitÃ©: 4G, Wifi et Bluetooth - Double SIM - Batterie: 5000mAh - Charge rapide 40W - 50% en 30 minutes - Empreinte digitale - Couleur: Noir - Garantie 1 an ', '/files/search_images/phones/1_2540.jpg', 'phones', '999', 891, 742, 6468.48, 8.7, '2024-05-23 18:58:30'),
	('5529795419', 'DISQUE DUR INTERNE PNY CS900 240GO SSD 2.5" (SSD7CS900-240-PB)', 'Disque Dur Interne PNY CS900 6 CapacitÃ© de stockage: 240 Go - Interface: SATA III 6Gb - Format de Disque: 2.5" - Vitesse en lecture: 535 Mo/s - Vitesse en Ã©criture: 500 Mo/s - Consommation d\'Ã©nergie: 2,2 W actif, 0,17 W au ralenti - Les SSD PNY sont jusqu\'Ã  30 fois plus robustes que les disques durs traditionnels -  Les mÃ©moires NAND non volatiles du systÃ¨me permettent au SSD de conserver les informations enregistrÃ©es mÃƒÂƒÃ‚Âªme si votre ordinateur chute - Garantie: 1 an', '/files/search_images/ssd/jgy_1.jpg', 'ssd', '79', 14, 777, 3084.02, 4.0, '2024-05-23 18:58:32'),
	('5911855006', 'IPHONE 13 PRO MAX 512GO GRAPHITE - APPLE', 'Ã©cran 6,1 OLED Super Retina XDR HDR - RÃ©solution: 2532 x 1170 pixels Ã  460 ppp - Processeur: Puce A15 Bionic (5 nm) Hexa-core ( 2x3.22 GHz Avalanche + 4xX.X GHz Blizzard) - GPU Graphics Apple 5 Coeurs - SystÃ¨me d\'exploitation: iOS 15 - MÃ©moire RAM: 6 Go - Stockage: 256 Go - Appareil photo ArriÃ¨re: Trio Pixels: 12 MÃ©gaPixels TÃ©lÃ©objectif avec ouverture Ã†Â’/2,8 + 12 MÃ©gaPixels avec ouverture Ã†Â’/1,5 + 12 MÃ©gaPixels Ultra grandÃ¢Â€Â‘angle avec ouverture Ã†Â’/1,8 et champ de vision de 120Ã‚Â° - Appareil Avant: 12 MÃ©gaPixels avec Ouverture Ã†Â’/2,2 - Video 4K HDR avec Wifi, RÃ©seau 5G , GPS , NFC et Bluetooth 5.0 - Batterie: Li-Ion 3095 mAh - Face ID - Couleur: Graphite - Garantie: 1 an', '/files/search_images/phones/1_2944.jpg', 'phones', '5,699', 472, 493, 2091.66, 4.2, '2024-05-23 18:58:29'),
	('6656860629', 'IPHONE 13 128GO ROUGE - APPLE', 'Ecran 6,1 OLED Super Retina XDR HDR - RÃ©solution: 2532 x 1170 pixels Ã  460 ppp - Processeur:  Puce A15 Bionic (5 nm) Hexa-core ( 2 x 3.22 GHz Avalanche + 4 x X.X GHz Blizzard) - GPU Graphics Apple 4 Coeurs - SystÃ¨me d\'exploitation: iOS 15 - MÃ©moire RAM: 4 Go - Stockage: 128 Go - Appareil photo ArriÃ¨re: Dual Pixels: 12 MÃ©gaPixels GrandÃ¢Â€Â‘angle avec ouverture Ã†Â’/1,6 + 12 MÃ©gaPixels Ultra grandÃ¢Â€Â‘angle avec ouverture Ã†Â’/2,4 et champ de vision de 120Ã‚Â° - Appareil Avant: 12 MÃ©gaPixels avec Ouverture Ã†Â’/2,2 - Video 4K HDR avec Wifi, RÃ©seau 5G , GPS , NFC et Bluetooth 5.0 - Batterie: Li-Ion 3240 mAh - Face ID - Couleur: Rouge - Garantie: 1 an', '/files/search_images/phones/1_2828.jpg', 'phones', '3,489', 829, 866, 7537.69, 8.7, '2024-05-23 18:58:29'),
	('6840501527', 'IPHONE 12 128GO NOIR - APPLE', 'Ecran 6,1  Super Retina XDR OLED - RÃ©solution: 1170 x 2532 pixels - Processeur: Apple A14 Bionic (5 nm) Hexa-core (2x3.1 GHz Firestorm + 4x1.8 GHz Icestorm) GPU Apple GPU (4-core graphics) - SystÃ©me d\'exploitation: iOS - MÃ©moire RAM: 4 Go - Stockage: 128Go - Appareil photo Arriere: Double: 12 MÃ©gaPixels  f/1.6 + 12 MÃ©gaPixels f/2.4 - Appareil Avant 12 MÃ©gaPixels f/2.2 avec Wifi, 4G et Bluetooth 5.0 - Batterie: Li-Ion 2815 mAh - RÃ©sistance Ã  l\'eau - Couleur: Noir - Garantie: 1 an', '/files/search_images/phones/1_2943.jpg', 'phones', '3,199', 85, 962, 2219.99, 2.3, '2024-05-23 18:58:30'),
	('6865012382', 'MONTRE CONNECTÃ©E BLULORY GLIFO AE - MARON', 'Montre ConnectÃ©e BLULORY Glifo AE - Ã©cran AMOLED Retina tactile 1,78 - ConnectivitÃ© Sans Fil: Bluetooth 5.0 - CapacitÃ© de batterie: 220mAh - Assistant vocal AI - GPS - NFC - Fonctions: podomÃ¨tre, suivi de la condition physique, suivi du sommeil, rappel de message, rappel d\'appel entrant, rÃ©ponse Ã  un appel, appel, message push, suivi de la frÃ©quence cardiaque, quran interactive, calendrier - IP68 ATM rÃ©sistance Ã  l\'eau - Couleur: Maron - Garantie: 1 an', '/files/search_images/montre/1_2397.jpg', 'montre', '229', 908, 631, 5820.62, 9.2, '2024-05-23 18:58:31'),
	('7087047391', 'Ã©COUTEURS SANS FIL ONEPLUS BUDS PRO - NOIR', 'Ã©couteurs Sans Fil ONEPLUS Buds Pro - Technologie de connectivitÃ©: Bluetooth 5.2 - Suppression adaptative et intelligente du bruit par IA - Mode Transparence - SensibilitÃ©: 98 dB ÃƒÂ‚Ã‚Â± 3dB - PortÃ©e de transmission: 10m - Autonomie: Lecture avec ANC activÃ©: Jusqu\'Ã  5 heures, Lecture avec ANC dÃ©sactivÃ©: Jusqu\'Ã  7 heures, Appel tÃ©lÃ©phonique: jusqu\'Ã  3 heures, Lecture combinÃ©e : Jusqu\'Ã  28 heures (ANC activÃ©), 38 heures (ANC dÃ©sactivÃ©) - Charge de distorsion: 10 minutes pour 10 heures (Ã©tui de charge + Ã©couteurs combinÃ©s) - CapacitÃ© de Batterie: 40 mAh(Par Ã©couteur), 520 mAh (Bouatier de charge ) - RÃ©sistant Ã  la sueur et Ã  l\'eau: IP55, IPX4 - Interface de charge Filaire, USB de type C (pour l\'Ã©tui de charge) - Couleur: Noir - Garantie: 1 an', '/files/search_images/kit/1_2312.jpg', 'kit', '499', 170, 461, 882.78, 1.9, '2024-05-23 18:58:32'),
	('7219969531', 'IMPRIMANTE Ã  RÃ©SERVOIR INTÃ©GRÃ© EPSON ECOTANK L3210 3EN1 COULEUR + 2 CADEAUXX', 'Imprimante Ã  RÃ©servoir IntÃ©grÃ© EPSON ECOTANK L3210 - Fonction: Impression, Copie, NumÃ©risation - Technologie d\'impression: Jet d\'encre (tÃƒÂªte d\'impression Epson Micro Piezo) - Vitesse d\'impression (N&B/Couleur): 33 pages/min , 15 pages/min - QualitÃ© d\'impression noir: 5.760 x 1.440 DPI (ppp) - QualitÃ© d\'impression couleur: 5.760 x 1.440 DPI (ppp) - Vitesse de NumÃ©risation: 11 s noir (200 DPI) / 32 s couleur (200 DPI) - Impression recto/verso: Manuel - Format Papier: A4 - Interface: USB - CapacitÃ© Papier: 30 feuilles - Dimensions: 375Ã¢Â€ÂŽ x 347 x 179 mm - Poids: 3.9 kg - Garantie: 1 an', '/files/search_images/print/bu-c11cj68403modifee_3.jpg', 'print', '579', 872, 652, 3277.22, 5.0, '2024-05-23 18:58:32'),
	('7219969532', 'Mens Home Authentic Shirt 22/23 White', 'Real madrid t-chirt without any sign', '/files/search_images/Real/HF0292-RMCFMZ0075-02_500x480.webp', 'Real', '534,340', 955, 187, 1769.52, 9.5, '2024-05-23 18:58:33'),
	('7219969533', 'Mens Home Authentic Shirt 22/23 White (LaLiga)', 'Real madrid t-chirt with La Liga + Club World Cup sign', '/files/search_images/Real/RMCFMZ0075_Laliga_500x480.webp', 'Real', '601,130', 619, 250, 1426.03, 5.7, '2024-05-23 18:58:33'),
	('7219969534', 'Mens Home Authentic Shirt 22/23 White (Champions League)', 'Real madrid t-chirt with Champions League + Club World Cup sign', '/files/search_images/Real/RMCFMZ0075_UCL_500x480.webp', 'Real', '601,130', 993, 94, 197.29, 2.1, '2024-05-23 18:58:33'),
	('7255650609', 'PC DE BUREAU GAMER MYTEK I5 10ÃƒÂˆ GÃ©N 8GO GTX 1660', 'Processeur: Intel Core i5-10400F (2,90 GHz up to 4,30 GHz Turbo max, 12Mo MÃ©moire cache, Hexa-Core) - SystÃ¨me d\'exploitation: FreeDos - MÃ©moire RAM: TEAM GROUP ELITE 8Go DDR4 3200Mhz - Disque Dur: TEAM GROUP disque dur interne SSD 512Go EX2 2.5" SATA III - Carte mÃ¨re: MSI H510M-A-PRO - Carte graphique: PALIT GAMER GTX 1660 DUAL 6G GDDR5 - BoÃƒÂ®tier XIGMATEK BOITIER SCORPIO II MINI TOUR ATX 4V /3VENTILATEURS - Alimentation NJOY TITAN+ 500W 80+ BRONZE - Dimensions: 370 x 185 x 390 mm - Couleur: Noir - Garantie: 1 an', '/files/search_images/PCs_bureau/kitana-i5-1660.jpg', 'PCs_bureau', '1,699', 135, 290, 2303.71, 7.9, '2024-05-23 18:58:31'),
	('7688629571', 'PC DE BUREAU GAMER MYTEK I3 10ÃƒÂˆ GÃ©N 8GO GTX 1650 VENTUS XS OC', 'Processeur: Intel Core i3-10100F (3,60 GHz up to 4,30 GHz Turbo max, 6Mo MÃ©moire cache,Quad-Core) - SystÃ¨me d\'exploitation: FreeDos - MÃ©moire RAM: TEAM GROUP  ELITE 8Go DDR4 3200- Disque Dur: TEAM GROUP CX2 SSD 2.5" 256 Go - Carte mÃ¨re: MSI H510M-A-PRO Micro-ATX - Carte graphique: MSI GEFORCE GTX 1650 VENTUS XS OC (4 Go de mÃ©moire dÃ©diÃ©e DDR6) - BoÃƒÂ®tier XIGMATEK Mini Tour ATX 4V RGB - XIGMATEK BLOC D\'ALIMENTATION ATX/600 W - 80PLUS WHITE - Dimensions: 370 x 185 x 390 mm - Couleur: Noir - Garantie: 1 an', '/files/search_images/PCs_bureau/kitana-i3-1650-v2-50.jpg', 'PCs_bureau', '1,469', 285, 683, 4888.58, 7.2, '2024-05-23 18:58:31'),
	('7868128334', 'SMARTPHONE SAMSUNG GALAXY A04 3GO 32GO - BLANC', 'Ã©cran 6.5" PLS LCD (720 x 1600px) - SystÃ¨me d\'exploitation: Android 12 - Processeur: Octa-core (4x2,3 GHz et 4x1,8 GHz) - MÃ©moire RAM: 3Go - Stockage: 32Go - Appareil photo ArriÃ¨re: Dual 50.0 MP f/1.8 + 2.0 MP f/2.4 - Appareil Photo Frontale: 5.0 MP f/2.2 - ConnectivitÃ©: 4G, Wifi et Bluetooth 5.0 - Double SIM - Capacite de la batterie: Li-Po 5000 mAh - Couleur: Blanc - Garantie: 1 an', '/files/search_images/phones/smartphone-samsung-galaxy-a04-3go-32go---blanc.jpg', 'phones', '499', 693, 619, 1639.39, 2.7, '2024-05-23 18:58:30'),
	('7873826523', 'PC PORTABLE GAMER LENOVO IDEAPAD 3 15ACH6 AMD RYZEN 5 8GO RTX 3050', 'Ã©cran 15.6" FULL HD IPS, 120Hz - Processeur: AMD Ryzen 5 5600H (3,3 GHz up to 4,2 GHz Turbo max ,16Mo de mÃ©moire cache, Hexa-Core) - SystÃ¨me d\'exploitation: Windows 11 Famille - MÃ©moire RAM: 8Go DDR4-3200 - Disque Dur: 512Go SSD - Carte Graphique: NVIDIA GeForce RTX 3050 (4Go de mÃ©moire dÃ©diÃ©e GDDR6) avec Wi-Fi, Bluetooth, 2x USB 3.2 Gen 1, 1x USB-C 3.2 Gen 1, 1x HDMI 2.0, 1x RJ-45, 1x prise combinÃ©e casque/microphone (3,5 mm) - Clavier RÃ©troÃ©clairÃ© blanc - Couleur: Noir - Garantie: 2 ans', '/files/search_images/PCs/82k2021yfg-w.jpg', 'PCs', '2,399', 247, 612, 4372.55, 7.1, '2024-05-23 18:58:30'),
	('7936319697', 'IPHONE 11 128 GO BLANC - APPLE', 'Ã©cran 6,1  LCD Retina IPS - RÃ©solution: 828 x 1792 pixels - Processeur: Apple A13 Bionic Hexa-core (2x2.65 GHz Lightning + 4x1.8 GHz Thunder) - SystÃ©me d\'exploitation: iOS - MÃ©moire RAM: 4 Go - Stockage: 128 Go - Appareil photo Arriere: Double: 12 MÃ©gaPixel (Ouverture f/1.8, 26mm) + 12 MÃ©gaPixels - Appareil Avant 12MÃ©gaPixels Retina Flash avec Wifi, 4G et Bluetooth 5.0 - Batterie: lithiumÃƒÂ¢Ã¢Â‚Â¬Ã¢Â€Â˜ion - Enregistrement vidÃ©o 4K - Temps de conversation Sans Fil: jusqu\'Ã  17 heures - ClassÃ© IP68 (profondeur maximale de 4 mÃ¨tres jusqu\'Ã  30 minutes) - Couleur: Blanc - Garantie: 1 an', '/files/search_images/phones/1_2941.jpg', 'phones', '2,649', 843, 37, 317.79, 8.6, '2024-05-23 18:58:30'),
	('8041163437', 'Ã©COUTEURS SANS FIL HUAWEI FREE BUDS SE - BLEU', 'Ã©couteurs Sans Fil HUAWEI Free Buds SE - ConnectivitÃ©: Bluetooth 5.2 - Un son Cristallin - Annulation des bruits d\'appel - CapacitÃ© de la Batterie : 37 mAh (par Ã©couteur), 410 mAh(bouatier de charge) - Autonomie de batterie: DurÃ©e de lecture de la quran : 6 heures, DurÃ©e des appels vocaux: 4 heures, Lecture de quran avec l\'Ã©tui de chargement: 24 heures, DurÃ©e des appels vocaux avec l\'Ã©tui de chargement: 16 heures - Temps de charge: Environ 1,5 heure pour les Ã©couteurs (dans l\'Ã©tui de chargement), Environ 2 heures pour l\'Ã©tui de chargement (en filaire, sans les Ã©couteurs) - Capteur G, Capteur Ã  effet Hall, Capteur infrarouge - RÃ©sistance aux Ã©claboussures, Ã  l\'eau et Ã  la poussiÃ¨re IPX4 - Couleur: Bleu - Garantie: 1 an', '/files/search_images/kit/010-02159-14_1097_1.jpg', 'kit', '219', 556, 364, 1564.10, 4.3, '2024-05-23 18:58:32'),
	('8149674823', 'SMARTPHONE BENCO V80 4GO 64GO - BLEU CYAN', 'Ã©cran 6.51" HD+ Waterdrop notch - Processeur: SC9863 Octa core 1,6 GHz - SystÃ©me d\'exploitation: Android 11 - MÃ©moire RAM: 4Go - Stockage: 64Go - camÃ©ra arriÃ¨re: Dual 8MP , Appareil Photo Frontale: 8MP - ConnectivitÃ©: Wifi 4G et Bluetooth - Double Sim - Batterie: 5000mAh - Capteur d\'empreinte digitale - Couleur: Bleu - Garantie: 1 an', '/files/search_images/phones/benco-v80-blue.jpg', 'phones', '349', 735, 735, 2301.73, 3.1, '2024-05-23 18:58:30'),
	('8405978653', 'TV SAMSUNG 50" SMART Q60B QLED 4K (2022)', 'TÃ©lÃ©viseur SAMSUNG 50 QLED 4K Smart TV- Processeur quantique Lite 4K - SystÃ¨me d\'exploitation: TizenMC - HDR 10+ - 100 % du volume colorimÃ©trique avec Quantum Dot - RÃ©solution: 3840 ÃƒÂƒÃ¢Â€Â” 2160 pixels - Audio: Dolby Digital Plus - Haut-Parleurs: 20 Watts - Type de haut-parleur: 2CH - Gradation Supreme UHD Dimming - Reduction du bruit - Audio Bluetooth - Bixby - Prise en charge de l\'application SmartThings - Mobile vers TV - Mode Ambiant - Auto Game Mode - Tuner analogique - ClÃ© TV - Design AirSlim - ConnectivitÃ©: Wi-Fi Direct, Bluetooth -  Connecteurs: 3 x HDMI, 2 x USB, 1 x Ethernet LAN, 1 x Entree RF, 1 x Sortie audio numÃ©rique - Dimensions: 1118.3 x 681.7 x 224 mm - Poids: 11.8 kg - Couleur: Noir - Garantie: 2 ans', '/files/search_images/TVs/1_2104_1.jpg', 'TVs', '2,599', 602, 608, 1212.94, 2.0, '2024-05-23 18:58:30'),
	('8492323078', 'SMARTPHONE OUKITEL WP20 4GO 32GO NOIR&ORANGE + PROTECTION Ã©CRAN + 25G DATA', 'Ã©cran: 5.93" HD+ (720 x 1440px) - Processeur: Quad core - SystÃ¨me d\'exploitation: Android 12 - MÃ©moire RAM: 4Go - Stockage: 32Go - Appareil Photo ArriÃ¨re: Dual AI 20 MP - Appareil Photo Frontale: 5 MP - CapacitÃ© de Batterie: 6300mAh - ConnectivitÃ©: haut dÃ©bit mobile 4G, Wifi et Bluetooth 5.0 - Couleur: Noir et Orange - Garantie: 1 an', '/files/search_images/phones/010-02159-14_1669_1.jpg', 'phones', '549.000', 900, 45, 292.88, 6.5, '2024-05-23 18:58:30'),
	('8868867333', 'MONTRE CONNECTÃ©E ARTEK PXS - NOIR', 'Ã©cran Amoled tactile 1,64" (456 x 180pixels) - ConnectivitÃ© Sans Fil: Bluetooth 5.0 - Autonomie: 15 jours en veille - MÃ©moire: 4Go - 24 type de modes sportifs - Fonctions principales:  FrÃ©quence cardiaque, Pression artÃ©rielle, OxygÃ¨ne sanguin, Rappel d\'appel et de message, Rappel sÃ©dentaire, Surveillance du sommeil, Calories, Distance, ChronomÃ¨tre, Alarme, Controle Ã  distance de la camÃ©ra - Commutateur Ã  plusieurs cadrans ( plusieurs options de cadrans de montre - CompatibilitÃ©: iOS 8.0 ou version ultÃ©rieure, Android 4.4 et supÃ©rieur - Couleur: Noir - Garantie: 1an', '/files/search_images/montre/3_761.jpg', 'montre', '179', 856, 135, 326.08, 2.4, '2024-05-23 18:58:31'),
	('8906107453', 'Ã©COUTEUR SANS FIL HUAWEI FREE BUDS LIPSTICK', 'Ã©couteur sans fil HUAWEI Free Buds Lipstick - Technologie de connectivitÃ©: Bluetooth 5.2 - CapacitÃ© de la batterie: 30 mAh(Par Ã©couteur) , Ã©tui de chargement : 410 mAh - lecture de quran : 2.5 heures (avec ANC activÃ©e), 4 heures (avec ANC dÃ©sactivÃ©e) - DurÃ©e d\'appel vocal: 2 heures (avec ANC activÃ©e), 3 heures (avec ANC dÃ©sactivÃ©e) - Temps de charge: environ 1 heure - Appairage via pop-up - Connexion par Bluetooth simultanÃ©e avec deux appareils - Commande tactile - RÃ©duction de Bruit Active open-fit - RÃ©duction de bruit d\'appel - RÃ©sistance aux Ã©claboussures, Ã  l\'eau et Ã  la poussiÃ¨re IPX4 ÃƒÂ¢Ã¢Â‚Â¬Ã¢Â€Âœ Couleur: Rouge - Garantie: 1an', '/files/search_images/kit/1_2273_1.jpg', 'kit', '299', 767, 911, 7793.38, 8.6, '2024-05-23 18:58:32'),
	('8937221979', 'Ã©COUTEURS SANS FIL QCY T1C BLUETOOTH - NOIR', 'Ã©couteurs Sans Fil QCY T1C - Technologie de connectivitÃ©: Bluetooth 5.0 - Autonomie des Ã©couteurs: 5 heures - Autonomie totale:25 heures - Temps de charge des Ã©couteurs: 1.5 heures - Temps de charge de la bouate: 2 heures - CapacitÃ© de la Batterie: 380mAh - RÃ©sistance Ã  l\'eau et Ã  la transpiration IPX4 - Convient pour Android et iOS - Distance Bluetooth: 10 m - Couleur: Noir - Garantie: 1an ', '/files/search_images/kit/bison-gt-byellow_227_1.jpg', 'kit', '59', 375, 202, 1157.44, 5.7, '2024-05-23 18:58:32'),
	('9171544415', 'AIRPODS SANS FIL PHILIPS TAT3255BK INTRA-AURICULAIRES - NOIR', 'AIRPODS SANS FIL PHILIPS TAT3255BK INTRA-AURICULAIRES - NOIR', '/files/search_images/kit/tat3255bk-00.jpg', 'kit', '189', 265, 394, 925.98, 2.4, '2024-05-23 18:58:31'),
	('9321704524', 'IMPRIMANTE JET D\'ENCRE CANON PIXMA G-2420 MULTIFONCTION 3EN1 COULEUR + CADEAU', 'Imprimante Jet D\'encre CANON PIXMA G-2420 - Imprimante ÃƒÂƒ rÃ©servoir intÃ©grÃ© - Fonctions: Impression, copie et numÃ©risation - Technologie d\'impression: Jet d\'encre Couleur - Vitesse d\'impression: Environ 9.1 ipm en noir, environ 6 ipm en couleur -  RÃ©solution d\'impression: 4800x1200dpi - RÃ©solution (optique) du scanner: 600 x 1200 ppp - Impression recto/verso: Manuel - Format: A4 - CapacitÃ© papier maximum en entrÃ©e(Bac arriÃ¨re): max. 100 feuilles (papier ordinaire) - ConnectivitÃ©: USB haute vitesse (port USB B) - Dimensions: 445 x 330 x 167 mm - Poids: 6,4 kg - Couleur: Noir - Garantie: 1 an', '/files/search_images/print/bu-g-2420_1.jpg', 'print', '469', 735, 469, 2451.30, 5.2, '2024-05-23 18:58:32'),
	('9413621964', 'MONTRE CONNECTÃ©E QCY GTC S1 - NOIR', 'Ã©cran TFT HD tactile 1.85" (240x280 pixels) - Verre incurvÃ© 2.5D - ConnectivitÃ©: Bluetooth 5.0 - Autonomie de batterie: 3-5 jours d\'utilisation intensive, Mode veille de 15 jours - 70 modes sportifs - Plus de 100 cadrans - Surveillance de la frÃ©quence cardiaque, DÃ©tection de la pression artÃ©rielle DÃ©tection SpO2, gÃ©rer son sommeil - RÃ©sistance Ã  l\'eau IP68 - Couleur: Noir - Garantie: 1an', '/files/search_images/montre/1_1950.jpg', 'montre', '179', 17, 518, 3222.97, 6.2, '2024-05-23 18:58:31');
