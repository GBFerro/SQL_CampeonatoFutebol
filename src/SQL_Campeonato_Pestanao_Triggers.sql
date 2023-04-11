CREATE OR ALTER TRIGGER IniciaJogo ON Jogo AFTER INSERT
AS
BEGIN
    DECLARE @Id int, @Time1 VARCHAR(100), @Time2 VARCHAR(100)
    WHILE (@Time1 is null OR @Time2 is null)
    BEGIN
        SELECT TOP 5 @Time1 = Nome FROM [Time] ORDER BY NEWID()
        SELECT TOP 5 @Time2 = Nome FROM [Time] ORDER BY NEWID()
        SELECT @Id = Id_Jogo FROM Jogo ORDER BY Id_Jogo ASC

        IF (@Time1 <> @Time2)
            BEGIN
            UPDATE [dbo].[Jogo]
            SET
                [Casa] = @Time1,
                [Visitante] = @Time2
            WHERE Id_Jogo = @Id
        END
        ELSE
        BEGIN
            SET @Time1 = NULL
            SET @Time2 = NULL
        END
    END
END
GO

CREATE OR ALTER TRIGGER ResultadoJogo ON Jogo AFTER UPDATE
AS
BEGIN
    IF (UPDATE(Visitante))
    BEGIN
        DECLARE @Id INT, @GolsCasa INT, @GolsVisitante INT, @Resultado VARCHAR(20)
        SELECT @Id = Id_Jogo FROM inserted ORDER BY Id_Jogo ASC

        SET @GolsCasa = FLOOR(RAND()*11)
        SET @GolsVisitante = FLOOR(RAND()*11)

        IF (@GolsCasa > @GolsVisitante)
        BEGIN
            SET @Resultado = 'Time mandante'
        END
        ELSE
        BEGIN
            IF (@GolsCasa < @GolsVisitante)
            BEGIN
                SET @Resultado = 'Time visitante'
            END
            ELSE
            BEGIN
                SET @Resultado = 'Empate'
            END
        END

        UPDATE [dbo].[Jogo]
        SET
            [Gols_Casa] = @GolsCasa,
            [Gols_Visitante] = @GolsVisitante,
            [Resultado] = @Resultado
        WHERE Id_Jogo = @Id

        SELECT * FROM Jogo
    END
END
GO

CREATE OR ALTER TRIGGER AdicionaPontuacao ON [Jogo] AFTER UPDATE
AS
BEGIN
    IF (UPDATE(Resultado))
    BEGIN
        DECLARE @Id INT, @Time1 VARCHAR(100), @Time2 VARCHAR(100), @Resultado VARCHAR(20), @PontuacaoCasa INT, @PontuacaoVisitante INT
        SELECT @Id = Id_Jogo FROM inserted ORDER BY Id_Jogo ASC
        SELECT @Time1 = Casa, @Time2 = Visitante, @Resultado = Resultado FROM Jogo WHERE Id_Jogo = @Id

        IF (@Resultado LIKE 'Empate')
        BEGIN
            SET @PontuacaoCasa = 1
            SET @PontuacaoVisitante = 1
        END
        ELSE
        BEGIN
            IF (@Resultado LIKE 'Time mandante')
            BEGIN
                SET @PontuacaoCasa = 3
                SET @PontuacaoVisitante = 0
            END
            ELSE
            BEGIN
                SET @PontuacaoCasa = 0
                SET @PontuacaoVisitante = 5
            END
        END

        UPDATE [dbo].[Time]
        SET
            [Pontuacao] = [Pontuacao] + @PontuacaoCasa
        WHERE Nome = @Time1

        UPDATE [dbo].[Time]
        SET
            [Pontuacao] = [Pontuacao] + @PontuacaoVisitante
        WHERE Nome = @Time2

    END
END
GO

CREATE OR ALTER TRIGGER AdicionaGols ON [Jogo] AFTER UPDATE
AS
BEGIN
    IF (UPDATE(Gols_Visitante))
    BEGIN
        DECLARE @Id INT, @Time1 VARCHAR(100), @Time2 VARCHAR(100), @GolsCasa INT, @GolsVisitante INT
        SELECT @Id = Id_Jogo FROM inserted ORDER BY Id_Jogo ASC
        SELECT @Time1 = Casa, @Time2 = Visitante, @GolsCasa = Gols_Casa, @GolsVisitante = Gols_Visitante FROM Jogo WHERE Id_Jogo = @Id

        UPDATE [dbo].[Time]
        SET
            [Gols_Marcados] = [Gols_Marcados] + @GolsCasa,
            [Gols_Recebidos] = [Gols_Recebidos] + @GolsVisitante
        WHERE Nome = @Time1

        UPDATE [dbo].[Time]
        SET
            [Gols_Marcados] = [Gols_Marcados] + @GolsVisitante,
            [Gols_Recebidos] = [Gols_Recebidos] + @GolsCasa
        WHERE Nome = @Time2

    END
END
GO