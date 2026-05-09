-- =============================================
-- GESTÃO PERSONAL — SCHEMA SUPABASE v2
-- =============================================

-- Tabela de alunos
CREATE TABLE IF NOT EXISTS gestao_alunos (
  id TEXT PRIMARY KEY,
  nome TEXT NOT NULL,
  nome_c TEXT NOT NULL,
  local TEXT NOT NULL CHECK (local IN ('FS','IC','PR','CD')),
  valor_ref NUMERIC DEFAULT 0,
  tel TEXT DEFAULT '',
  email TEXT DEFAULT '',
  nasc DATE,
  prof TEXT DEFAULT '',
  obj TEXT DEFAULT '',
  obj_s TEXT DEFAULT '',
  freq TEXT DEFAULT '',
  nivel TEXT DEFAULT '',
  obj_d TEXT DEFAULT '',
  obj_o TEXT DEFAULT '',
  saude JSONB DEFAULT '{}',
  medidas JSONB DEFAULT '{}',
  medidas_hist JSONB DEFAULT '[]',
  ativo BOOLEAN DEFAULT true,
  criado_em TIMESTAMPTZ DEFAULT NOW(),
  atualizado_em TIMESTAMPTZ DEFAULT NOW()
);

-- Tabela de registro de aulas
CREATE TABLE IF NOT EXISTS gestao_registro (
  id SERIAL PRIMARY KEY,
  ano INT NOT NULL,
  mes INT NOT NULL,
  dia INT NOT NULL,
  slot INT NOT NULL,
  nome_c TEXT NOT NULL,
  criado_em TIMESTAMPTZ DEFAULT NOW(),
  UNIQUE(ano, mes, dia, slot)
);

-- Tabela de pagamentos
CREATE TABLE IF NOT EXISTS gestao_pagamentos (
  id TEXT PRIMARY KEY,
  aluno_id TEXT NOT NULL REFERENCES gestao_alunos(id) ON DELETE CASCADE,
  ano INT NOT NULL,
  mes INT NOT NULL,
  status TEXT DEFAULT 'pendente' CHECK (status IN ('pago','pendente','atrasado')),
  valor NUMERIC DEFAULT 0,
  nf BOOLEAN DEFAULT false,
  criado_em TIMESTAMPTZ DEFAULT NOW(),
  atualizado_em TIMESTAMPTZ DEFAULT NOW(),
  UNIQUE(aluno_id, ano, mes)
);

-- Índices
CREATE INDEX IF NOT EXISTS idx_registro_data ON gestao_registro(ano, mes, dia);
CREATE INDEX IF NOT EXISTS idx_pagamentos_aluno ON gestao_pagamentos(aluno_id, ano, mes);

-- Dados dos alunos (nasc NULL onde não há data)
INSERT INTO gestao_alunos (id, nome, nome_c, local, valor_ref, tel, email, nasc, prof, obj, obj_s, saude, medidas, medidas_hist) VALUES
('AL001','Adriana de Toledo','ADRI','FS',3000,'48996248120','',NULL,'Médica','Condicionamento','Saúde geral','{"obs":"Sem anamnese cadastrada"}','{"peso":54,"altura":169}','[]'),
('AL002','Marcio Zimmermann','MARCIO','FS',1300,'48988196655','',NULL,'Empresário','Condicionamento','','{"obs":"Sem anamnese cadastrada"}','{}','[]'),
('AL003','Aquilles de Queiroz','AQUILLES','FS',1500,'48999821911','',NULL,'Aposentado','Condicionamento','','{"obs":"Sem anamnese cadastrada"}','{"peso":48,"altura":159}','[]'),
('AL004','Rodrigo Tessari','RODRIGO','FS',2100,'48999116546','rodrigo.tessari@gmail.com','1988-09-30','Empresário','Emagrecimento','Melhora da saúde','{"cirurgia":"Desvio de septo","obs":"Alergia a contraste iodado. Cirurgia de desvio de septo."}','{"peso":140,"altura":181}','[]'),
('AL005','Luíza Soncini','LUIZA','FS',1400,'48991300184','draluizasoncini@gmail.com','1984-12-03','Dentista','Saúde geral','Condicionamento','{"lesoes":"Dor nas costas lado esquerdo","obs":"Dor nas costas lado esquerdo (trabalho). Fortalecer."}','{"peso":55,"altura":166}','[]'),
('AL006','Marcelo Luchi Salum','MARCELO','FS',1750,'48999614822','marcelo.salum@me.com','1976-10-01','Arquiteto','Hipertrofia','Saúde geral','{"doencas":"Histórico de miocardite (em tratamento)","cirurgia":"Desvio de septo","obs":"Histórico de miocardite. Cirurgia de desvio de septo."}','{"peso":80,"altura":184}','[]'),
('AL007','João Paulo Dalazen','JOÃO','IC',1500,'54991476673','joao.dalazen@gmail.com','1988-03-26','Médico','Hipertrofia','Condicionamento','{"doencas":"Ansiedade e insônia (medicado)","med":"Medicação para ansiedade e insônia","lesoes":"Joelho D: osteoartrite, rotura menisco, condromalacia grau III/IV","cirurgia":"Artroscopia quadril D, fasciotomia, reimplantação glúteo médio D","obs":"Joelho D: osteoartrite, rotura menisco, condromalacia III/IV."}','{"peso":82,"altura":185}','[]'),
('AL008','Maira Caren','MAIRA','CD',1750,'3102280377','mairacaren@gmail.com','1977-12-16','Designer','Condicionamento','Emagrecimento','{"lesoes":"Dor lombar e tendinite antebraço esquerdo","obs":"Dor lombar e tendinite antebraço esquerdo."}','{"peso":64,"altura":167}','[]'),
('AL009','Lecyan Slovinski','LECYAN','CD',2100,'48999636858','lecyan@seusadvogados.com.br','1956-10-07','Advogado','Condicionamento','Prep. esporte','{"lesoes":"Dor residual no ombro pós-cirurgia","cirurgia":"Cirurgia no ombro","obs":"Cirurgia no ombro — dor residual."}','{"peso":84,"altura":176}','[]'),
('AL010','Raquel Strazzabosco','RAQUEL','CD',1400,'55984182838','raquel@roveda.com.br','1983-08-30','Empresária','Emagrecimento','Saúde geral','{"doencas":"Rinite alérgica controlada","lesoes":"Túnel do carpo e tendinite cotovelos","obs":"Rinite alérgica. Tunnel do carpo. Tendinite cotovelos."}','{"peso":60,"altura":165}','[]'),
('AL011','Amanda H V Feijó','AMANDA','CD',1200,'48996161696','amandahvieira@gmail.com','1987-09-06','Func. pública','Emagrecimento','Saúde geral','{"doencas":"Asma","lesoes":"Dores nos pés, lombar e quadril D","cirurgia":"Retirada da vesícula","obs":"Asma. Retirada vesícula. Dores nos pés, lombar e quadril D."}','{"peso":100,"altura":161}','[]'),
('AL012','Adelar Martins','ADELAR','PR',1450,'48999193598','adelarmartins77@gmail.com','1977-02-23','Marceneiro','Condicionamento','Saúde geral','{"doencas":"Alergia à penicilina","lesoes":"Dor lombar","obs":"Dor lombar. Alergia à penicilina."}','{"peso":66,"altura":170}','[]'),
('AL013','Luan Perruci','LUAN','PR',500,'48996885525','luanperruci@gmail.com','1990-08-16','Autônomo','Hipertrofia','Saúde geral','{"doencas":"Alergia a medicamentos e coisas ácidas","obs":"Alergia a medicamentos e coisas ácidas."}','{"peso":84,"altura":183}','[]'),
('AL014','Matheus De Oliveira','MATHEUS','PR',600,'','matheusoliv1999@gmail.com','1999-11-09','Empresário','Hipertrofia','Prep. esporte','{"lesoes":"Dor residual no ombro","cirurgia":"Cirurgia no ombro","obs":"Cirurgia no ombro."}','{"peso":96,"altura":185}','[]')
ON CONFLICT (id) DO NOTHING;

