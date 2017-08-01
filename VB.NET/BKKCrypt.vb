
Public Interface ICrypt
    Function Encrypt(ByVal input As String) As String
End Interface

Public Class BKKCrypt
    Implements ICrypt

    Function Encrypt(ByVal input As String) As String Implements ICrypt.Encrypt
        Return input
    End Function
End Class

