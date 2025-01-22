CREATE TABLE IF NOT EXISTS clients (
    id_client UUID PRIMARY KEY,
    limits INTEGER NOT NULL,
    balance INTEGER NOT NULL DEFAULT 0
);

INSERT INTO clients (id_client, limits, balance) VALUES
('36291ce1-f1d2-4a62-b05b-4af6f62b05a3', 100000, 0),
('99a1dec3-aed8-47bb-8309-318c012c02fb', 80000, 0),
('9e85ffb9-dbd0-41ce-a4c1-d80ab0c53fb6', 1000000, 0),
('f3a7ba5d-82f9-47ab-ab4b-8f7744ff0434', 10000000, 0),
('3fbb9786-2e38-461a-92df-21fc6c9f558e', 500000, 0),
('399dfb5c-071c-4edf-bfba-8f875e65def2', 100000, 0),
('e66ca0ad-5514-4bbd-ad24-987830e76a49', 80000, 0),
('bb7a3d9f-8405-44ae-99ae-914183281be7', 1000000, 0),
('e0fa3529-95fb-4b91-9c60-be257946015f', 10000000, 0),
('51c20b43-b307-4d00-b790-d147194fe26a', 500000, 0),
('0c814a88-8dd8-4945-b6ad-b7a6abec23b1', 100000, 0),
('fa2d8b37-5c1c-4f91-8503-633e8a907d3c', 80000, 0),
('906985b4-10bd-4035-8164-18de77219be8', 1000000, 0),
('d4d0bb33-83ed-4cb9-8c5e-e5a9a1192d50', 10000000, 0),
('d44003c6-304d-4304-8d74-b87fa9631439', 500000, 0),
('2cd96c29-fd40-489d-bd2d-538d94c0b235', 100000, 0),
('e705ee08-049a-48c5-8028-10c5606d6b9f', 80000, 0),
('813416ba-bec5-4383-a24c-7591cc1f5c67', 1000000, 0),
('da2ae01e-100a-49a6-af7e-6ec18ee53c1b', 10000000, 0),
('f35c4d89-3525-4c90-829b-8c73965d8ddc', 500000, 0),
('18a606b9-c05e-446d-a5e8-6ffcc7090f7c', 100000, 0),
('5d3f3326-0e7b-41e3-aa49-1c0e01eb2ca2', 80000, 0),
('1b005659-ff2d-4d71-b873-ebedf7896363', 1000000, 0),
('05ff258c-d4e4-4a74-a3f1-c18e37798551', 10000000, 0),
('c47fabc4-f831-4f4d-95e2-f4fd3bed947d', 500000, 0),
('a535d9b5-f39d-404f-be25-7114a906d244', 100000, 0),
('0bc207ae-50bc-40e1-8a3a-cb588c2e2db3', 80000, 0),
('e598540d-62ee-4535-b962-947fe37ec231', 1000000, 0),
('47bc7f69-b46c-4232-997e-c117b7af2c06', 10000000, 0),
('3e74e4ef-55fd-4cc5-8085-d7dca1100cae', 500000, 0),
('8042a2ff-039e-4d8e-a220-d076003a4b80', 100000, 0),
('4b523599-d7e5-4da2-8cd0-26a29dd24c98', 80000, 0),
('8d489f88-2bff-4e9b-90bc-8ec97ef60408', 1000000, 0),
('6a8e1bd1-76ad-4ecd-b427-7cf7da7061af', 10000000, 0),
('a77fb75d-571c-4bc8-b561-8f4bc682248e', 500000, 0),
('3331f6a9-70f6-4c58-b949-544fdbdcc1a9', 100000, 0),
('a5a2cdc7-a002-483e-8fcd-340b9dfee532', 80000, 0),
('dae2e968-1694-4143-8f7b-85df83ac98ed', 1000000, 0),
('1643d5cf-9842-402c-887c-15cef34686fb', 10000000, 0),
('e2e76076-8906-4d73-acd0-07c28b0ed8a7', 500000, 0),
('2c038ffc-664c-4be6-8a03-a49b5bc85219', 100000, 0),
('38e0ff7e-a896-49fa-907f-2754e6652fa4', 80000, 0),
('8ec7ce6a-a843-42bd-bac8-b6a17019044f', 1000000, 0),
('e50c4b86-38af-44f8-93eb-034acbc1c01b', 10000000, 0),
('c34cf0bd-c570-4fc6-b32a-afc61f7f2107', 500000, 0),
('d6bf90d1-bb71-4699-9c33-a071f25c552f', 100000, 0),
('9b4fbee9-940b-498b-a38a-38207512e888', 80000, 0),
('872f42fd-abd1-4082-a014-5e9ed009eacc', 1000000, 0),
('cea556b0-3aeb-4dee-8850-557572260cd8', 10000000, 0),
('444391c6-dd0e-4d57-9b53-595f4f1dd82a', 500000, 0);
