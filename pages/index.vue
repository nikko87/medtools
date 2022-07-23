<template>
  <v-row justify="center" align="center">
    <v-col cols="12" sm="8" md="6">
      <v-card class="logo py-4 d-flex justify-center">
        <NuxtLogo />
      </v-card>
      <v-card>
        <v-card-title class="headline">
          Bem vindo ao MedTools v1.0
        </v-card-title>
        <v-card-text>
          <p>MEDTools é uma suíte de ferramentas para facilitar a vida do médico.</p>
          <p>Desenvolvido por Dr. Nikolas de Castro</p>
          <p>Contato: <strong>nikolascastro87@gmail.com</strong></p>
        </v-card-text>
      </v-card>
    </v-col>
  </v-row>
</template>

<script>
export default {
  name: 'IndexPage'
}
</script>
