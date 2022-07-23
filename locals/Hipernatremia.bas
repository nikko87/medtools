B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Activity
Version=5.2
@EndOfDesignText@
#Region  Activity Attributes 
	#FullScreen: False
	#IncludeTitle: True
#End Region

Sub Process_Globals

End Sub

Sub Globals

	Private sv1 As ScrollView
	Private btnCalcular As Button
	Private txtSodioDesejado As EditText
	Private txtSodioPaciente As EditText
	Private txtPeso As EditText
	Private chkSexoFeminino As CheckBox
	Private sab As StdActionBar
End Sub

Sub Activity_Create(FirstTime As Boolean)
	Activity.LoadLayout("layout_sv_container")
	sv1.Panel.LoadLayout("layoutHiperNa")
	Activity.Title = "HIPERNATREMIA"
	
	sab.Initialize("sab")
	sab.Subtitle = "Cálculo do déficit/reposição de água"
	Activity.AddMenuItem("Detalhes", "mnuDetalhes")
End Sub

Sub mnuDetalhes_click
	Main.help_url = "file:///android_asset/hipernatremia.html"
	StartActivity(ActivityWebView)
End Sub

Sub Activity_Resume

End Sub

Sub Activity_Pause (UserClosed As Boolean)

End Sub


Sub btnCalcular_Click
	Dim deficit_agua, peso, sodio_pct, sodio_desejado As Float
	Dim rep_agua_enteral, rep_SG, rep_salina02, rep_salina045 As Float
	Dim str As String
	
	Try	
		peso = txtPeso.Text
		sodio_desejado = txtSodioDesejado.Text
		sodio_pct = txtSodioPaciente.Text
		
		If chkSexoFeminino.Checked Then
			deficit_agua = (0.4 * peso) * ((sodio_pct/sodio_desejado) -1)
		Else
			deficit_agua = (0.5 * peso) * ((sodio_pct/sodio_desejado) -1)
		End If
		
		deficit_agua = deficit_agua * 1000 'transforma de Litros para Mililitros
		
		rep_agua_enteral = deficit_agua
		rep_SG = deficit_agua 
		rep_salina02 = deficit_agua * 1.33 
		rep_salina045 = deficit_agua * 2
		
		Log("deficit_agua = " & Floor(deficit_agua))
		Log("salina 0,2% = " & Floor(rep_salina02))
		Log("salina 0,45% = " & Floor(rep_salina045))
		
		Dim lst As List
		lst.Initialize
		lst.Add("Reposição de água: ")
		lst.Add(">> Água enteral: " & Floor(rep_agua_enteral) & " ml  (" & Floor(rep_agua_enteral / 24) & " ml/h)")
		lst.Add(">> SG 5%: " & Floor(rep_SG) & " ml  (" & Floor(rep_SG / 24) & " ml/h)")
		lst.Add(">> Sol. salina a 0,2%: " & Floor(rep_salina02) & " ml  (" & Floor(rep_salina02 / 24) & " ml/h)")
		lst.Add(">> Sol. salina a 0,45%: " & Floor(rep_salina045) & " ml  (" & Floor(rep_salina045 / 24) & " ml/h)")
		Prescricao.lst = lst
		StartActivity(Prescricao)

	Catch
		ToastMessageShow("Verifique os campos!", True)
	End Try
		
	
End Sub
