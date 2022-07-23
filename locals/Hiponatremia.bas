B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Activity
Version=5.2
@EndOfDesignText@
#Region  Activity Attributes 
	#FullScreen: False
	#IncludeTitle: true
	
#End Region

Sub Process_Globals

End Sub

Sub Globals
	Private btnCalcular As Button
	Private txtPeso As EditText
	Private txtSodio As EditText
	Private SAB As StdActionBar
	
	Private chkSexoFeminino As CheckBox
	Private sv1 As ScrollView
	Private btnCalcularNaCorrigido As Button
	Private txtGlicemia As EditText
End Sub

Sub Activity_Create(FirstTime As Boolean)
	Activity.LoadLayout("layout_sv_container")
	sv1.Panel.LoadLayout("layoutHipoN")
	
	SAB.Initialize("sab")
	SAB.Subtitle = "Cálculo de reposição de sódio"
	Activity.Title = "HIPONATREMIA"
	Activity.AddMenuItem("Detalhes", "mnuDetalhes")
	
End Sub


Sub Activity_Resume

End Sub

Sub mnuDetalhes_click
	
	Main.help_url = "file:///android_asset/hiponatremia.html"
	StartActivity(ActivityWebView)
	
End Sub

Sub txtPeso_FocusChanged (HasFocus As Boolean)
	If HasFocus Then
		sv1.ScrollPosition = txtPeso.Top - 10dip
	End If
End Sub

Sub txtSodio_FocusChanged (HasFocus As Boolean)
	If HasFocus Then
		sv1.ScrollPosition = txtSodio.Top - 10dip
	End If
End Sub

Sub btnCalcular_Click
	Dim agua_corporal As Float
	Dim sodio_soro, variacaoNaPorLitro As Float
	Dim peso_pct, sodio_pct As Float
	Dim qtdeEm3h, qtdeEm21h As String
	
	Try
		peso_pct = txtPeso.Text
		sodio_pct = txtSodio.Text
		sodio_soro = 513
		
		If chkSexoFeminino.Checked Then
			agua_corporal = 0.5 * peso_pct
		Else
			agua_corporal = 0.6 * peso_pct
		End If
		
		variacaoNaPorLitro = (sodio_soro - sodio_pct) / (agua_corporal + 1)
		
		'total 10 mEq em 24h (3 em 3h, 9 em 21h)
		qtdeEm3h = NumberFormat(3 / variacaoNaPorLitro,1,3) * 1000
		qtdeEm21h = NumberFormat(7 / variacaoNaPorLitro, 1, 3) * 1000
			

		Dim lst As List
		lst.Initialize
		lst.Add("Solução salina a 3%" & CRLF)
		lst.Add(">> " & qtdeEm3h & "ml em 3h  [" & Floor(qtdeEm3h / 3) & "ml/h <> " & Floor(qtdeEm3h/3/3) & "gts/min]" & CRLF)
		lst.Add(">> " & qtdeEm21h & "ml em 21h   [" & Floor(qtdeEm21h/21) & "ml/h <> "  & Floor(qtdeEm3h/21/3) & "gts/min]")
		Prescricao.lst = lst
		StartActivity(Prescricao)

	Catch
		ToastMessageShow("Verifique os campos!", True)
	End Try
	
	Log(variacaoNaPorLitro)
	Log(qtdeEm3h)
	Log(qtdeEm21h)
	
End Sub
Sub btnCalcularNaCorrigido_Click
	Dim na_pct, glicemia, na_corrigido As Float
	
	If txtSodio.Text = "" Or txtGlicemia.Text = "" Then
		ToastMessageShow("Verifique os campos!", True)
		Return 
			
	End If
	
	Try
		na_pct = txtSodio.Text
		glicemia = txtGlicemia.Text
		
		na_corrigido = na_pct + (Floor((glicemia - 100) / 100) * 1.6)
		
		Msgbox("Na+ corrigido = " & Floor(na_corrigido) & " mg/dl", "Na+ corrigido")
	Catch
		ToastMessageShow("Erro ao calcular Na+ corrigido!", True)
	End Try
	
End Sub