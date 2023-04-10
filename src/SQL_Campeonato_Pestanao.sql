CREATE DATABASE CampeonatoPestanao;
GO

USE CampeonatoPestanao;
GO


CREATE TABLE Time (
    [Nome] VARCHAR(100) NOT NULL,
    [Apelido] VARCHAR(100) NULL,
    [DataCriacao] DATE NOT NULL,
    [Pontuacao] INT DEFAULT 0,
    [Gols_Marcados] INT DEFAULT 0,
    [Gols_Recebidos] INT DEFAULT 0

    CONSTRAINT PK_Time PRIMARY KEY (Nome)
)
GO

CREATE TABLE Campeonato (
    [Nome] VARCHAR(50) NOT NULL,
    [Ano] INT NOT NULL

    CONSTRAINT PK_Campeonato PRIMARY KEY (Nome, Ano)
)
GO

CREATE TABLE Jogo (
    [Id_Jogo] INT IDENTITY NOT NULL,
    [Nome_Camp] VARCHAR(50) NOT NULL,
    [Ano_Camp] INT NOT NULL,
    [Casa] VARCHAR(100) NULL,
    [Gols_Casa] INT NULL,
    [Visitante] VARCHAR(100) NULL,
    [Gols_Visitante] INT NULL,
    [Resultado] VARCHAR(20) NULL

    CONSTRAINT PK_Jogo PRIMARY KEY (Id_Jogo),
    CONSTRAINT UN_Jogo UNIQUE (Casa, Visitante),
    CONSTRAINT FK_Jogo_Campeonato FOREIGN KEY (Nome_Camp, Ano_Camp) REFERENCES Campeonato(Nome, Ano),
    CONSTRAINT FK_Jogo_TimeCasa FOREIGN KEY (Casa) REFERENCES [Time](Nome),
    CONSTRAINT FK_Jogo_TimeVisitante FOREIGN KEY (Visitante) REFERENCES [Time](Nome),
)
GO

-- CREATE TABLE Jogo_Time (
--     [Id_JT] INT IDENTITY NOT NULL,
--     [JT_Casa] VARCHAR(100) NOT NULL,
--     [JT_Visitante] VARCHAR(100) NOT NULL,
--     [Gols_Casa] INT NULL,
--     [Gols_Visitante] INT NULL,

--     CONSTRAINT PK_Jogo_Time PRIMARY KEY (JT_Casa, JT_Visitante),
--     CONSTRAINT FK_Jogo_Time_TimeCasa FOREIGN KEY (JT_Casa) REFERENCES [Time](Nome),
--     CONSTRAINT FK_Jogo_Time_TimeVisitante FOREIGN KEY (JT_Visitante) REFERENCES [Time](Nome),
--     CONSTRAINT FK_Jogo_Time_Jogo FOREIGN KEY (Id_JT) REFERENCES Jogo(Id_Jogo)
-- )
-- GO

--POPULANDO AS TABELAS

-- INICIA CAMPEONATO
EXEC.IniciarCampeonato 'Campeonato Pestanão', 2023
GO

-- INSERE TIMES
EXEC.InserirTimes 'Papini F.C', 'Tigrão', '2022-08-12'
GO
EXEC.InserirTimes 'Pestana F.C', 'Cavalo Manco', '2022-08-12'
GO
EXEC.InserirTimes 'Portuga F.C', 'Vasco da Gama', '2022-08-12'
GO
EXEC.InserirTimes 'Estrela da Morte F.C', 'Death Star', '2022-08-12'
GO
EXEC.InserirTimes 'Juarez F.C', 'José F.C', '2022-08-12'
GO

-- FAZ SELEÇÃO DOS TIMES QUE IRÃO SE ENFRENTAR
EXEC.IniciarJogo 'Campeonato Pestanão', 2023
GO

-- ========================================
SELECT * FROM [dbo].[Campeonato] 
SELECT * FROM [dbo].[Jogo]
SELECT * FROM [dbo].[Time]

EXEC.ClassificarPodio
EXEC.Campeao

EXEC.Artilheiro
EXEC.Frangalha

IF OBJECT_ID('[dbo].[Campeonato]', 'U') IS NOT NULL
DROP TABLE [dbo].[Campeonato]
GO
IF OBJECT_ID('[dbo].[Time]', 'U') IS NOT NULL
DROP TABLE [dbo].[Time]
GO
IF OBJECT_ID('[dbo].[Jogo]', 'U') IS NOT NULL
DROP TABLE [dbo].[Jogo]
GO