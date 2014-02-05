VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "NetResourceInfo"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Compare Text
Option Explicit

' From "Visual Basic Language Developer's Handbook"
' by Ken Getz and Mike Gilbert
' Copyright 2000; Sybex, Inc. All rights reserved.

Private mstrLocalName As String
Private mstrRemoteName As String
Private mstrComment As String
Private mstrProvider As String

Public Property Get LocalName() As String
    LocalName = mstrLocalName
End Property

Friend Property Let LocalName(strLocalName As String)
    mstrLocalName = strLocalName
End Property

Public Property Get RemoteName() As String
    RemoteName = mstrRemoteName
End Property

Friend Property Let RemoteName(strRemoteName As String)
    mstrRemoteName = strRemoteName
End Property

Public Property Get Comment() As String
    Comment = mstrComment
End Property

Friend Property Let Comment(strComment As String)
    mstrComment = strComment
End Property

Public Property Get Provider() As String
    Provider = mstrProvider
End Property

Friend Property Let Provider(strProvider As String)
    mstrProvider = strProvider
End Property

