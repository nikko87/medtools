<template>
<v-container>

  <v-row justify="center">
    <v-col
      cols="12"
      md="6"
      lg="5"
      sm="8"
      xs="12">

      <v-row justify="center pb-4">
        <h1>HIPONATREMIA</h1>
      </v-row>
      <v-card
        elevation="5"
        class="mb-6"
        shaped>

        <v-card-title>Peso</v-card-title>
        <v-divider></v-divider>

        <v-row class="pa-4">

          <v-col>
            <v-row
              align="center"
              justify="center"
              no-gutters>
              <v-icon
                size="64"
                color="green darken-2"> mdi-weight-kilogram </v-icon>
            </v-row>

          </v-col>

          <v-col>

            <v-text-field
              ref="name"
              v-model="peso"
              :rules="[() => !!peso || 'Campo obrigatório']"
              label="Peso do paciente:"
              placeholder="Kg"
              outlined
              clearable
              required></v-text-field>

          </v-col>
        </v-row>

      </v-card>

      <v-card
        elevation="5"
        class="mb-6"
        shaped>

        <v-card-title>Sódio</v-card-title>

        <v-divider></v-divider>

        <v-row class="pa-4">

          <v-col align-self="center">
              <h1 class="text-center">[ Na+ ]</h1>
          </v-col>

          <v-col>

            <v-row
              justify="center"
              no-gutters
              align-content="space-between">

              <v-text-field
                v-model="sodio"
                label="Na+ do paciente"
                outlined
                clearable
                required></v-text-field>

              <v-text-field
                v-model="sodioSoro"
                label="Na+ do soro"
                outlined
                clearable
                required></v-text-field>
            </v-row>

          </v-col>

        </v-row>

      </v-card>

      <v-card
        elevation="5"
        shaped>

        <v-card-title>Prescrição</v-card-title>

        <v-divider></v-divider>

        <v-card-text class="subtitle-2">Solução salina a 3%:</v-card-text>
        <v-card-text>{{ (calc3h/3).toFixed(1)}}ml/h nas primeiras 3h</v-card-text>
        <v-card-text>{{ (calc21h/21).toFixed(1)}}ml/h nas próximas 21h </v-card-text>

      </v-card>

    </v-col>
  </v-row>
</v-container>
</template>

<script>
export default {
  name: 'Hiponatremia',
  data() {
    return {
      peso: 70,
      sodio: 120,
      sodioSoro: 513, // nacl 3%
      mulher: false,
      totalVarSodio24h: 8,
    }
  },
  methods: {
    calcAguaCorporal: function () {
      if (this.mulher) {
        return 0.5 * this.peso
      }
      return 0.6 * this.peso
    },
    variacaoNaPorLitro: function () {
      return (this.sodioSoro - this.sodio) / (this.calcAguaCorporal() + 1)
    },
  },
  computed: {
    calc3h: function () {
      return 3 / this.variacaoNaPorLitro() * 1000
    },
    calc21h: function () {
      return (this.totalVarSodio24h - 3) / this.variacaoNaPorLitro() * 1000
    }
  }

}
</script>

<style>

</style>
