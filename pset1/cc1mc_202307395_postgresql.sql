--Criação do banco de dados

drop database if exists uvv;
drop user if exists arthur;
create user arthur with createdb createrole encrypted password 'artgomes';
set role arthur;
create database uvv 
with owner = arthur
template = template0
encoding = 'UTF8'
lc_collate = 'pt_BR.UTF-8'
lc_ctype = 'pt_BR.UTF-8'
allow_connections = true;


\connect "dbname=uvv user=arthur password=artgomes";

--Aqui foi definido o search_path do banco de dados e o owner do banco de dados

CREATE SCHEMA lojas;

alter database uvv set search_path to lojas, '$user', public;

ALTER USER arthur SET search_path TO lojas, '$user', public;

SET search_path TO lojas, '$user', public;

ALTER SCHEMA lojas OWNER TO arthur;

--Aqui foi criada a tabela lojas.produtos

CREATE TABLE lojas.produtos (
                    produto_id                NUMERIC(38) NOT NULL,
                    nome                      VARCHAR(255) NOT NULL,
                    preco_unitario            NUMERIC(10,2),
                    detalhes                  BYTEA,
                    imagem                    BYTEA,
                    imagem_mime_type          VARCHAR(512),
                    imagem_arquivo            VARCHAR(512),
                    imagem_charset            VARCHAR(512),
                    imagem_ultima_atualizacao DATE,
                    CONSTRAINT pk_produto_id_ PRIMARY KEY (produto_id)
);

COMMENT ON TABLE  produtos IS                           'tabela de produtos';
COMMENT ON COLUMN produtos.produto_id IS                'identificador do produto';
COMMENT ON COLUMN produtos.nome IS                      'nome de cada produto';
COMMENT ON COLUMN produtos.preco_unitario IS            'preco unitario de cada produto';
COMMENT ON COLUMN produtos.detalhes IS                  'detalhes de cada produto';
COMMENT ON COLUMN produtos.imagem IS                    'imagem de cada produto';
COMMENT ON COLUMN produtos.imagem_mime_type IS          'imagem mime type';
COMMENT ON COLUMN produtos.imagem_arquivo IS            'imagem do arquivo de cada produto';
COMMENT ON COLUMN produtos.imagem_charset IS            'image charset';
COMMENT ON COLUMN produtos.imagem_ultima_atualizacao IS 'imagem ultima atualizacao de cada produto';

--Aqui foi criada a tabela lojas.lojas

CREATE TABLE lojas.lojas (
                    loja_id                 NUMERIC(38) NOT NULL,
                    nome                    VARCHAR(255) NOT NULL,
                    endereco_web            VARCHAR(255),
                    endereco_fisico         VARCHAR(100),
                    latitude                NUMERIC,
                    longitude               NUMERIC,
                    logo                    BYTEA,
                    logo_mime_type          VARCHAR(512),
                    logo_arquivo            VARCHAR(512),
                    logo_charset            VARCHAR(512),
                    logo_ultima_atualizacao DATE,
                    CONSTRAINT pk_loja_id_  PRIMARY KEY (loja_id)
);

COMMENT ON TABLE lojas IS                          'tabela das lojas';
COMMENT ON COLUMN lojas.loja_id IS                 'identificador de cada loja';
COMMENT ON COLUMN lojas.nome IS                    'nome de cada loja';
COMMENT ON COLUMN lojas.endereco_web IS            'endereço web de cada loja';
COMMENT ON COLUMN lojas.endereco_fisico IS         'endereco fisico de cada loja';
COMMENT ON COLUMN lojas.latitude IS                'latitude de cada loja';
COMMENT ON COLUMN lojas.longitude IS               'longitude de cada loja';
COMMENT ON COLUMN lojas.logo IS                    'logo de cada loja';
COMMENT ON COLUMN lojas.logo_mime_type IS          'logo mime type';
COMMENT ON COLUMN lojas.logo_arquivo IS            'logo do arquivo de cada loja';
COMMENT ON COLUMN lojas.logo_charset IS            'logo charset';
COMMENT ON COLUMN lojas.logo_ultima_atualizacao IS 'logo ultima atualizacao';

--Aqui foi criada a tabela lojas.estoques

CREATE TABLE lojas.estoques (
                    estoque_id               NUMERIC(38) NOT NULL,
                    loja_id                  NUMERIC(38) NOT NULL,
                    produto_id               NUMERIC(38) NOT NULL,
                    quantidade               NUMERIC(38) NOT NULL,
                    CONSTRAINT pk_estoque_id PRIMARY KEY (estoque_id)
);
COMMENT ON TABLE estoques IS              'tabela do estoque';
COMMENT ON COLUMN estoques.estoque_id IS  'identificador de estoque';
COMMENT ON COLUMN estoques.loja_id IS     'identificador de cada loja';
COMMENT ON COLUMN estoques.produto_id IS  'identificador do produto';
COMMENT ON COLUMN estoques.quantidade IS  'quantidade de estoque';

--Aqui foi criada a tabela lojas.clientes

CREATE TABLE lojas.clientes (
                cliente_id               NUMERIC(38) NOT NULL,
                email                    VARCHAR(255) NOT NULL,
                nome                     VARCHAR(255) NOT NULL,
                telefone1                VARCHAR(20),
                telefone2                VARCHAR(20),
                telefone3                VARCHAR(20),
                CONSTRAINT pk_cliente_id PRIMARY KEY (cliente_id)
);

COMMENT ON TABLE clientes IS              'a tabela clientes contém informações sobre os clientes.';
COMMENT ON COLUMN clientes.cliente_id IS  'identificador da primary key da tabela "clientes"';
COMMENT ON COLUMN clientes.email IS       'identificador do email de cada cliente';
COMMENT ON COLUMN clientes.nome IS        'identificador do nome de cada cliente';
COMMENT ON COLUMN clientes.telefone1 IS   'primeiro telefone registrado do cliente';
COMMENT ON COLUMN clientes.telefone2 IS   'identificador do segundo telefone registrado do cliente';
COMMENT ON COLUMN clientes.telefone3 IS   'identificador do terceiro telefone registrado do cliente';

--Aqui foi criada a tabela lojas.envios

CREATE TABLE lojas.envios (
                envio_id               NUMERIC(38) NOT NULL,
                loja_id                NUMERIC(38) NOT NULL,
                cliente_id             NUMERIC(38) NOT NULL,
                endereco_entrega       VARCHAR(512) NOT NULL,
                status                 VARCHAR(15) NOT NULL,
                CONSTRAINT pk_envio_id PRIMARY KEY (envio_id)
);

COMMENT ON TABLE envios IS                   'tabela de envios de cada produto';
COMMENT ON COLUMN envios.envio_id IS         'identificador de envio';
COMMENT ON COLUMN envios.loja_id IS          'identificador de cada loja';
COMMENT ON COLUMN envios.cliente_id IS       'identificador da primary key da tabela "clientes"';
COMMENT ON COLUMN envios.endereco_entrega IS 'endereco de entrega';
COMMENT ON COLUMN envios.status IS           'status do envio';

--Aqui foi criada a tabela lojas.pedidos

CREATE TABLE lojas.pedidos (
                pedido_id               NUMERIC(38) NOT NULL,
                cliente_id              NUMERIC(38) NOT NULL,
                data_hora               TIMESTAMP NOT NULL,
                status                  VARCHAR(15) NOT NULL,
                loja_id                 NUMERIC(38) NOT NULL,
                CONSTRAINT pk_pedido_id PRIMARY KEY (pedido_id)
);

COMMENT ON TABLE pedidos IS             'tabela com as informacoes dos pedidos de cada cliente.';
COMMENT ON COLUMN pedidos.pedido_id IS  'identificador do pedido de cada cliente';
COMMENT ON COLUMN pedidos.cliente_id IS 'identificador da primary key da tabela "clientes"';
COMMENT ON COLUMN pedidos.data_hora IS  'data e hora do pedido de cada cliente';
COMMENT ON COLUMN pedidos.cliente_id IS 'foreign key: identificador do cliente.';
COMMENT ON COLUMN pedidos.status IS     'status do pedido';
COMMENT ON COLUMN pedidos.loja_id IS    'identificador de cada loja';

--Aqui foi criada a tabela lojas.pedidos_itens

CREATE TABLE lojas.pedidos_itens (
                pedido_id                   NUMERIC(38) NOT NULL,
                produto_id                  NUMERIC(38) NOT NULL,
                numero_da_linha             NUMERIC(38) NOT NULL,
                preco_unitario              NUMERIC(10,2) NOT NULL,
                quantidade                  NUMERIC(38) NOT NULL,
                envio_id                    NUMERIC(38) NOT NULL,
                CONSTRAINT pfk_pedidosItens PRIMARY KEY (pedido_id, produto_id)
);

COMMENT ON TABLE pedidos_itens IS                  'tabela de pedidos';
COMMENT ON COLUMN pedidos_itens.pedido_id IS       'identificador do pedido de cada cliente';
COMMENT ON COLUMN pedidos_itens.produto_id IS      'identificador do produto';
COMMENT ON COLUMN pedidos_itens.numero_da_linha IS 'numero da linha';
COMMENT ON COLUMN pedidos_itens.preco_unitario IS  'preco unitario de cada pedido';
COMMENT ON COLUMN pedidos_itens.quantidade IS      'quantidade de pedidos';
COMMENT ON COLUMN pedidos_itens.envio_id IS        'identificador de envio';

--Aqui foi criada uma foreign key da tabela produtos para a tabela estoques

ALTER TABLE estoques ADD CONSTRAINT produtos_estoques_fk
FOREIGN KEY (produto_id)
REFERENCES produtos (produto_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

--Aqui foi criada uma foreign key da tabela produtos para a tabela pedidos_itens

ALTER TABLE pedidos_itens ADD CONSTRAINT produtos_pedidos_itens_fk
FOREIGN KEY (produto_id)
REFERENCES produtos (produto_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

--Aqui foi criada uma foreign key da tabela lojas para a tabela pedidos

ALTER TABLE pedidos ADD CONSTRAINT lojas_pedidos_fk
FOREIGN KEY (loja_id)
REFERENCES lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

--Aqui foi criada uma foreign key da tabela lojas para a tabela envios

ALTER TABLE envios ADD CONSTRAINT lojas_envios_fk
FOREIGN KEY (loja_id)
REFERENCES lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

--Aqui foi criada uma foreign key da tabela lojas para a tabela estoques 

ALTER TABLE estoques ADD CONSTRAINT lojas_estoques_fk
FOREIGN KEY (loja_id)
REFERENCES lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

--Aqui foi criada uma foreign key da tabela clientes para a tabela pedidos

ALTER TABLE pedidos ADD CONSTRAINT clientes_pedidos_fk
FOREIGN KEY (cliente_id)
REFERENCES clientes (cliente_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

--Aqui foi criada uma foreign key da tabela clientes para a tabela envios

ALTER TABLE envios ADD CONSTRAINT clientes_envios_fk
FOREIGN KEY (cliente_id)
REFERENCES clientes (cliente_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

--Aqui foi crida uma foreign key da tabela envios para a tabela pedidos_itens

ALTER TABLE pedidos_itens ADD CONSTRAINT envios_pedidos_itens_fk
FOREIGN KEY (envio_id)
REFERENCES envios (envio_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

--Aqui foi criada uma foreign key da tabela pedidos para a tabela pedidos_itens

ALTER TABLE pedidos_itens ADD CONSTRAINT pedidos_pedidos_itens_fk
FOREIGN KEY (pedido_id)
REFERENCES pedidos (pedido_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;



--Checks

--Essa check faz com que o valor dos produtos não possa ser negativo

ALTER TABLE lojas.produtos
ADD CONSTRAINT preco_unitario_nao_negativo
CHECK (preco_unitario >= 0);

--Essa check faz com que o preço unitário não seja negativo

ALTER TABLE lojas.pedidos_itens
ADD CONSTRAINT preco_unitario_nao_negativo
CHECK (preco_unitario >= 0);

--Essa check faz com que a quantidade de pedidos não possa ser negativa

ALTER TABLE lojas.pedidos_itens
ADD CONSTRAINT quantidade_nao_negativo
CHECK (quantidade >= 0);

--Essa check faz com que a coluna status só possa conter os valores inseridos abaixo na tabela lojas.envios

ALTER TABLE lojas.envios
ADD CONSTRAINT status_envios
CHECK (status IN ('CRIADO', 'ENVIADO', 'TRANSITO', 'ENTREGUE'));

--Essa check faz com que a coluna status só possa conter os valores inseridos abaixo na tabela lojas.pedidos 

ALTER TABLE lojas.pedidos
ADD CONSTRAINT status_pedidos 
CHECK (status IN ('CANCELADO', 'COMPLETO', 'ABERTO', 'PAGO', 'REEMBOLSADO', 'ENVIADO'));

--Essa check faz com que o endereco_web e o endereco_fisico não sejam nulos

ALTER TABLE lojas.lojas
ADD CONSTRAINT endereco_fisico
CHECK (endereco_web IS NOT NULL OR endereco_fisico IS NOT NULL);




