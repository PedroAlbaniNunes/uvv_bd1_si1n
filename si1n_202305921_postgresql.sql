--Bloco inicial--
--Excluir o BD caso exista--
DROP DATABASE IF EXISTS uvv;

-------------------------------
--Excluir o schema caso exista--
DROP SCHEMA IF EXISTS lojas CASCADE;

-------------------------------
--Excluir o usuário caso exista--
DROP USER IF EXISTS pedroa;

-------------------------------

--Criar o usuário a ser usado--
CREATE USER pedroa WITH
CREATEDB
CREATEROLE
INHERIT
ENCRYPTED PASSWORD'pedro';

-------------------------------


--Conectar no usuário a ser utilizado

SET ROLE pedroa;

-------------------------------

--Criar o BD a ser usado--
CREATE DATABASE uvv WITH
TEMPLATE = 'template0'
ENCODING = 'UTF8'
LC_COLLATE =  'pt_BR.UTF-8'
LC_CTYPE =  'pt_BR.UTF-8'
ALLOW_CONNECTIONS = 'true'
OWNER = 'pedroa';


--Conectar no banco de dados e usuário--
\c uvv;

SET ROLE pedroa;

-------------------------------


--Criar o schema a ser usado--
CREATE SCHEMA IF NOT EXISTS lojas AUTHORIZATION pedroa;

ALTER USER pedroa
SET SEARCH_PATH TO lojas, "&user", public;


-----------Fim do bloco inicial-------------


--Bloco produtos--


--Criar a tabela produtos-- 
CREATE TABLE lojas.produtos (
                produto_id                 NUMERIC(38)      NOT NULL,
                nome                       VARCHAR(255)     NOT NULL,
                preco_unitario             NUMERIC(10,2),
                detalhes                   BYTEA,
                imagem                     BYTEA,
                imagem_mime_type           VARCHAR(512),
                imagem_arquivo             VARCHAR(512),
                imagem_charset             VARCHAR(512),
                imagem_atualizacao_produto DATE,
                CONSTRAINT pk_produtos PRIMARY KEY (produto_id)
);


--Comentários acerca das colunas da tabela produtos--

COMMENT ON TABLE lojas.produtos                             IS 'Tabela com os dados dos produtos';
COMMENT ON COLUMN lojas.produtos.produto_id                 IS 'Coluna com o identificador de cada produto.';
COMMENT ON COLUMN lojas.produtos.nome                       IS 'Coluna com o nome de cada produto.';
COMMENT ON COLUMN lojas.produtos.preco_unitario             IS 'Coluna com o preco unitario de cada produto a mostra.';
COMMENT ON COLUMN lojas.produtos.detalhes                   IS 'Coluna com o arquivo binário com o detalhamento dos produtos com um detalhamento.';
COMMENT ON COLUMN lojas.produtos.imagem                     IS 'Coluna com o arquivo de imagem binaria dos produtos com uma imagem.';
COMMENT ON COLUMN lojas.produtos.imagem_mime_type           IS 'Coluna com a imagem do produto no tipo MIME(Multipurpose Internet Mail Extension), formato para transmitir na internet.';
COMMENT ON COLUMN lojas.produtos.imagem_arquivo             IS 'Coluna com o arquivo da imagem do produto.';
COMMENT ON COLUMN lojas.produtos.imagem_charset             IS 'Coluna com o character set da imagem do produto.';
COMMENT ON COLUMN lojas.produtos.imagem_atualizacao_produto IS 'Coluna com a data da ultima atualizacao da imagem do produto.';



--Bloco lojas--

--Criar a tabela lojas--
CREATE TABLE lojas.lojas (
                loja_id                   NUMERIC(38)    NOT NULL,
                nome                      VARCHAR(255)   NOT NULL,
                endereco_web              VARCHAR(100),
                endereco_fisico           VARCHAR(512),
                latitude                  NUMERIC,
                longitude                 NUMERIC,
                logo BYTEA,
                logo_mime_type            VARCHAR(512),
                logo_arquivo              VARCHAR(512),
                logo_charset              VARCHAR(512),
                logo_ultima_atualizacao   DATE,
                CONSTRAINT pk_lojas PRIMARY KEY (loja_id)
);

--Comentários acerca das colunas da tabelas lojas--

COMMENT ON TABLE lojas.lojas                          IS 'Tabela com os dados das lojas.';
COMMENT ON COLUMN lojas.lojas.loja_id                 IS 'Coluna com o identificador de cada loja.';
COMMENT ON COLUMN lojas.lojas.nome                    IS 'Coluna com o nome de cada loja.';
COMMENT ON COLUMN lojas.lojas.endereco_web             IS 'Coluna com o endereço web(link/url) das lojas com um endereço web.';
COMMENT ON COLUMN lojas.lojas.endereco_fisico          IS 'Coluna com o endereço fisico de cada loja com um endereço fisico.';
COMMENT ON COLUMN lojas.lojas.latitude                IS 'Coluna com a latitude das lojas com endereço fisico.';
COMMENT ON COLUMN lojas.lojas.longitude               IS 'Coluna com a longitude das loja com endereço fisico.';
COMMENT ON COLUMN lojas.lojas.logo                    IS 'Coluna com o binário da imagem usada na logo das lojas que tenham logo.';
COMMENT ON COLUMN lojas.lojas.logo_mime_type          IS 'Coluna com a logo tipo MIME(Multipurpose Internet Mail Extension), formato para transmitir na internet.';
COMMENT ON COLUMN lojas.lojas.logo_arquivo            IS 'Coluna com o arquivo da logo.';
COMMENT ON COLUMN lojas.lojas.logo_charset            IS 'Coluna com o character set da logo.';
COMMENT ON COLUMN lojas.lojas.logo_ultima_atualizacao IS 'Coluna com a data da ultima atualizacao da logo.';


--Bloco estoques--

--Criar a tabela estoques--
CREATE TABLE lojas.estoques (
                estoque_id        NUMERIC(38)    NOT NULL,
                loja_id           NUMERIC(38)    NOT NULL,
                produto_id        NUMERIC(38)    NOT NULL,
                quantidade        NUMERIC        NOT NULL,
                CONSTRAINT pk_estoques PRIMARY KEY (estoque_id)
);

--Comentários acerca das colunas da tabela estoques--
COMMENT ON TABLE lojas.estoques             IS 'Tabela com os dados dos estoques.';
COMMENT ON COLUMN lojas.estoques.estoque_id IS 'Coluna com o identificador de cada estoque.';
COMMENT ON COLUMN lojas.estoques.loja_id    IS 'Coluna com o identificador de cada loja.';
COMMENT ON COLUMN lojas.estoques.produto_id IS 'Coluna com o identificador de cada produto.';
COMMENT ON COLUMN lojas.estoques.quantidade IS 'Coluna com a quantidade de cada produto em estoque.';

--Bloco clientes--

--Criar a tabela clientes--
CREATE TABLE lojas.clientes (
                cliente_id      NUMERIC       NOT NULL,
                email           VARCHAR(255)  NOT NULL,
                nome            VARCHAR(255)  NOT NULL,
                telefone1       VARCHAR(20),
                telefone2       VARCHAR(20),
                telefone3       VARCHAR(20),
                CONSTRAINT pk_clientes PRIMARY KEY (cliente_id)
);

--Comentários acerca das colunas da tabela clientes--
COMMENT ON TABLE lojas.clientes             IS 'Tabela com os dados dos clientes.';
COMMENT ON COLUMN lojas.clientes.cliente_id IS 'Coluna com o identificador de cada cliente.';
COMMENT ON COLUMN lojas.clientes.email      IS 'Coluna com o email de cada cliente.';
COMMENT ON COLUMN lojas.clientes.nome       IS 'Coluna com o nome de cada cliente.';
COMMENT ON COLUMN lojas.clientes.telefone1  IS 'Coluna com o telefone primário de cada cliente.';
COMMENT ON COLUMN lojas.clientes.telefone2  IS 'Coluna com o telefone secundário de cada cliente.';
COMMENT ON COLUMN lojas.clientes.telefone3  IS 'Coluna com o telefone terciário de cada cliente.';


--Bloco envios--

--Criar a tablea envios--
CREATE TABLE lojas.envios (
                envio_id               NUMERIC(38)  NOT NULL,
                loja_id                NUMERIC(38)  NOT NULL,
                cliente_id             NUMERIC      NOT NULL,
                endereco_entrega       VARCHAR(512) NOT NULL,
                status                 VARCHAR(15)  NOT NULL,
                CONSTRAINT pk_envios PRIMARY KEY (envio_id)
);

--Comentários acerca das colunas da tabela envios--
COMMENT ON TABLE lojas.envios                   IS 'Tabela com os dados dos envios.';
COMMENT ON COLUMN lojas.envios.envio_id         IS 'Coluna com o identificador de cada envio.';
COMMENT ON COLUMN lojas.envios.loja_id          IS 'Coluna com o identificador de cada loja.';
COMMENT ON COLUMN lojas.envios.cliente_id       IS 'Coluna com o identificador de cada cliente.';
COMMENT ON COLUMN lojas.envios.endereco_entrega IS 'Coluna com o endereco de entrega de cada envio.';
COMMENT ON COLUMN lojas.envios.status           IS 'Coluna com o status de cada envio.';


--Bloco pedidos--

--Criar a tabela pedidos--
CREATE TABLE lojas.pedidos (
                pedido_id          NUMERIC(38)   NOT NULL,
                data_hora          TIMESTAMP     NOT NULL,
                cliente_id         NUMERIC       NOT NULL,
                status             VARCHAR(15)   NOT NULL,
                loja_id            NUMERIC(38)   NOT NULL,
                CONSTRAINT pk_pedidos PRIMARY KEY (pedido_id)
);

--Comentários acerca das colunas da tabela pedidos--
COMMENT ON TABLE lojas.pedidos             IS 'Tabela com os dados dos pedidos.';
COMMENT ON COLUMN lojas.pedidos.pedido_id  IS 'Coluna com o identificador de cada pedido.';
COMMENT ON COLUMN lojas.pedidos.data_hora  IS 'Coluna com o registro da data e hora de cada pedido.';
COMMENT ON COLUMN lojas.pedidos.cliente_id IS 'Coluna com o identificador de cada cliente.';
COMMENT ON COLUMN lojas.pedidos.status     IS 'Coluna com o status de cada pedido.';
COMMENT ON COLUMN lojas.pedidos.loja_id    IS 'Coluna com o identificador de cada loja.';


--Bloco pedidos_itens--

--Criar a tabela pedidos_itens--
CREATE TABLE lojas.pedidos_itens (
                pedido_id             NUMERIC(38)    NOT NULL,
                produto_id            NUMERIC(38)    NOT NULL,
                numero_da_linha       NUMERIC(38)    NOT NULL,
                preco_unitario        NUMERIC(10,2)  NOT NULL,
                quantidade            NUMERIC(38)    NOT NULL,
                envio_id              NUMERIC(38)    NOT NULL,
                CONSTRAINT pk_pedidos_itens PRIMARY KEY (pedido_id, produto_id)
);

--Comentários acerca da coluna da tabela pedidos_itens--
COMMENT ON TABLE lojas.pedidos_itens                  IS 'Tabela com os dados relacionados entre pedidos e os itens(produtos).';
COMMENT ON COLUMN lojas.pedidos_itens.pedido_id       IS 'Coluna com o identificador de cada pedido.';
COMMENT ON COLUMN lojas.pedidos_itens.produto_id      IS 'Coluna com o identificador de cada produto.';
COMMENT ON COLUMN lojas.pedidos_itens.numero_da_linha IS 'Coluna com o numero da linha dos pedidos.';
COMMENT ON COLUMN lojas.pedidos_itens.preco_unitario  IS 'Preco unitario do produto junto ao envio.';
COMMENT ON COLUMN lojas.pedidos_itens.quantidade      IS 'Coluna com a quantidade de cada produto por pedido.';
COMMENT ON COLUMN lojas.pedidos_itens.envio_id        IS 'Coluna com o identificador de cada envio.';


--Começo do bloco de relacionamentos--

--Relacionamentos da tabela estoques--
ALTER TABLE lojas.estoques ADD CONSTRAINT produtos_estoques_fk
FOREIGN KEY (produto_id)
REFERENCES lojas.produtos (produto_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE lojas.estoques ADD CONSTRAINT lojas_estoques_fk
FOREIGN KEY (loja_id)
REFERENCES lojas.lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

--Fim dos relacionamentos da tabela estoques--



--Começo dos relacinamentos da tabela pedidos-itens--

ALTER TABLE lojas.pedidos_itens ADD CONSTRAINT produtos_pedidos_itens_fk
FOREIGN KEY (produto_id)
REFERENCES lojas.produtos (produto_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE lojas.pedidos_itens ADD CONSTRAINT envios_pedidos_itens_fk
FOREIGN KEY (envio_id)
REFERENCES lojas.envios (envio_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE lojas.pedidos_itens ADD CONSTRAINT pedidos_pedidos_itens_fk
FOREIGN KEY (pedido_id)
REFERENCES lojas.pedidos (pedido_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;



--Fim dos relacionamentos da tabela pedidos-itens--



--Começo dos relacinamentos da tabela pedidos--



ALTER TABLE lojas.pedidos ADD CONSTRAINT lojas_pedidos_fk
FOREIGN KEY (loja_id)
REFERENCES lojas.lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE lojas.pedidos ADD CONSTRAINT clientes_pedidos_fk
FOREIGN KEY (cliente_id)
REFERENCES lojas.clientes (cliente_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;



--Fim dos relacionamentos da tabela pedidos--



--Começo dos relacionamentos da tabela envios



ALTER TABLE lojas.envios ADD CONSTRAINT lojas_envios_fk
FOREIGN KEY (loja_id)
REFERENCES lojas.lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE lojas.envios ADD CONSTRAINT clientes_envios_fk
FOREIGN KEY (cliente_id)
REFERENCES lojas.clientes (cliente_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;



--Fim do relacionament da tabela envios--



--Começo do bloco de restrições--



--Restrições da tabela clientes--



ALTER TABLE lojas.clientes
ADD CONSTRAINT cc_cliente_id_clientes
CHECK (clientes.cliente_id > 0);

ALTER TABLE lojas.clientes
ADD CONSTRAINT cc_email_clientes
CHECK (clientes.email ~* '^[A-Za-z0-9._%+-]+@+[A-Za-z0-9.-]+[A-Za-z]{2,}$');

ALTER TABLE lojas.clientes
ADD CONSTRAINT cc_telefone1_clientes
CHECK (clientes.telefone1 ~ '^[0-9]+$');

ALTER TABLE lojas.clientes
ADD CONSTRAINT cc_telefone2_clientes
CHECK (clientes.telefone2 ~ '^[0-9]+$');

ALTER TABLE lojas.clientes
ADD CONSTRAINT cc_telefone3_clientes
CHECK (clientes.telefone3 ~ '^[0-9]+$');



--Fim das restrições da tabela clientes--




--Restrições da tabela pedidos--



ALTER TABLE lojas.pedidos
ADD CONSTRAINT cc_pedido_id_pedidos
CHECK (pedidos.pedido_id > 0);

ALTER TABLE lojas.pedidos
ADD CONSTRAINT cc_status_pedidos
CHECK (pedidos.status IN('CANCELADO', 'COMPLETO', 'ABERTO', 'PAGO', 'REEMBOLSADO', 'ENVIADO'));



--Fim das restrições da tabela pedidos--



--Restrições da tabela lojas--



ALTER TABLE lojas.lojas
ADD CONSTRAINT cc_loja_id_lojas
CHECK (lojas.loja_id > 0);

ALTER TABLE lojas.lojas
ADD CONSTRAINT cc_endereco_web_endereco_fisico_lojas
CHECK (lojas.endereco_web IS NOT NULL OR lojas.endereco_fisico IS NOT NULL);

ALTER TABLE lojas.lojas
ADD CONSTRAINT cc_latitude_lojas
CHECK (lojas.latitude >= -90 AND lojas.latitude <= 90);

ALTER TABLE lojas.lojas
ADD CONSTRAINT cc_longitute_lojas
CHECK (lojas.longitude >= -180 AND lojas.longitude <= 180);



--Fim das restrições da tabela lojas--



--Restrições da tabela produtos--



ALTER TABLE lojas.produtos
ADD CONSTRAINT cc_produto_id_produtos
CHECK (produtos.produto_id > 0);

ALTER TABLE lojas.produtos
ADD CONSTRAINT cc_preco_unitario_produtos
CHECK (produtos.preco_unitario > 0);



--Fim das restrições da tabela produtos--



--Restrições da tabela envios--



ALTER TABLE lojas.envios
ADD CONSTRAINT cc_envio_id_envios
CHECK (envios.envio_id > 0);

ALTER TABLE lojas.envios
ADD CONSTRAINT cc_status_envios
CHECK (envios.status IN ( 'CRIADO', 'ENVIADO', 'TRANSITO', 'ENTREGUE'));



--Fim das restrições da tabela envios--



--Restrições da tabela estoques--



ALTER TABLE lojas.estoques
ADD CONSTRAINT cc_estoque_id_estoques
CHECK (estoque_id > 0);

ALTER TABLE lojas.estoques
ADD CONSTRAINT cc_quantitade_estoques
CHECK (estoques.quantidade >= 0);



--Fim das restrições da tabela estoques--



--Restrições da tabela pedidos_itens--



ALTER TABLE lojas.pedidos_itens
ADD CONSTRAINT cc_pedidos_unitario_pedidos_itens
CHECK (pedidos_itens.preco_unitario > 0);

ALTER TABLE lojas.pedidos_itens
ADD CONSTRAINT cc_quantidade_pedidos_itens
CHECK (pedidos_itens.quantidade >= 0);



--Fim das restrições da tabela pedidos_itens--


