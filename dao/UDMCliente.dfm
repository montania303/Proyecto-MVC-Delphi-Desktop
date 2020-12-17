object DMCliente: TDMCliente
  OldCreateOrder = False
  Height = 242
  Width = 579
  object DSPBuscar: TDataSetProvider
    DataSet = SQLBuscar
    Left = 32
    Top = 72
  end
  object CDSBuscar: TClientDataSet
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'NOME'
        ParamType = ptInput
      end>
    ProviderName = 'DSPBuscar'
    Left = 32
    Top = 136
    object CDSBuscarID: TIntegerField
      FieldName = 'ID'
      Required = True
    end
    object CDSBuscarNOME: TStringField
      FieldName = 'NOME'
      Size = 60
    end
    object CDSBuscarDATA_NASCIMENTO: TDateField
      FieldName = 'DATA_NASCIMENTO'
    end
    object CDSBuscarIDADE: TLargeintField
      FieldName = 'IDADE'
    end
    object CDSBuscarPAIS: TStringField
      FieldName = 'PAIS'
      Size = 30
    end
    object CDSBuscarTELEFONE: TStringField
      FieldName = 'TELEFONE'
    end
  end
  object SQLBuscar: TSQLDataSet
    CommandText = 'SELECT *'#13#10'  FROM CLIENTE'#13#10' WHERE CLIENTE.nome like :NOME'
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftUnknown
        Name = 'NOME'
        ParamType = ptInput
      end>
    SQLConnection = DMConexion.SQLConnection
    Left = 32
    Top = 8
  end
  object SQLActualizar: TSQLDataSet
    CommandText = 
      'update cliente'#13#10'           set nome = :nome,'#13#10'               dat' +
      'a_nascimento = :data_nascimento,'#13#10'               pais = :pais,'#13#10 +
      '               telefone = :telefone,'#13#10'               prod_ativo ' +
      '= :prod_ativo'#13#10'           where (id = :id)'
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftString
        Name = 'nome'
        ParamType = ptInput
      end
      item
        DataType = ftDate
        Name = 'data_nascimento'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'pais'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'telefone'
        ParamType = ptInput
      end
      item
        DataType = ftUnknown
        Name = 'id'
        ParamType = ptInput
      end>
    SQLConnection = DMConexion.SQLConnection
    Left = 168
    Top = 8
  end
  object SQLEliminar: TSQLDataSet
    CommandText = 'delete from cliente'#13#10'           where (id = :id)'
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftInteger
        Name = 'id'
        ParamType = ptInput
      end>
    SQLConnection = DMConexion.SQLConnection
    Left = 240
    Top = 8
  end
  object SQLInsertar: TSQLDataSet
    CommandText = 
      'insert into cliente (id, nome, data_nascimento, pais, telefone, ' +
      'prod_ativo)'#13#10'    values (:id, :nome, :data_nascimento, :pais, :t' +
      'elefone, :prod_ativo)'
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftInteger
        Name = 'id'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'nome'
        ParamType = ptInput
      end
      item
        DataType = ftDateTime
        Name = 'data_nascimento'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'pais'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'telefone'
        ParamType = ptInput
      end>
    SQLConnection = DMConexion.SQLConnection
    Left = 96
    Top = 8
  end
end