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
              type="number"
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

        <v-card-title>Dados</v-card-title>

        <v-divider></v-divider>

        <v-row class="pa-4">

          <v-col align-self="center">
            <h1 class="text-center">[ Na+ ]</h1>
            <v-card-text class="text-center">
              Solução salina a 3%: <strong>513 mEq/L</strong>
            </v-card-text>
            <v-card-text class="text-center">
              Na+ corrigido: <strong> {{ calcNaCorrigido.toFixed(1) }} </strong>
            </v-card-text>
          </v-col>

          <v-col>

            <v-row
              justify="center"
              no-gutters
              align-content="space-between">

              <v-text-field
                v-model="sodio"
                label="Na+ do paciente"
                type="number"
                outlined
                clearable
                required></v-text-field>

              <v-text-field
                v-model="glicemia"
                label="Glicemia do paciente"
                outlined
                type="number"
                clearable
                required></v-text-field>
              <v-checkbox
                v-model="mulher"
                label="Mulher?"></v-checkbox>

            </v-row>

          </v-col>

        </v-row>

      </v-card>

      <v-card
        elevation="5"
        shaped>

        <v-card-title>Prescrição</v-card-title>

        <v-divider></v-divider>

        <v-card-text class="subtitle-2">Solução salina a 3% (SF 0,9% 900ml + NaCl 20% 100ml):</v-card-text>
        <v-card-text><strong>{{ (calc3h/3).toFixed(1)}}ml/h </strong> nas primeiras 3h <small>({{ calc3h.toFixed(1) }}ml)</small> </v-card-text>
        <v-card-text><strong>{{ (calc21h/21).toFixed(1)}}ml/h </strong> nas próximas 21h <small>({{ calc21h.toFixed(1) }}ml)</small> </v-card-text>

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
      glicemia: 100,
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
    },
    calcNaCorrigido: function () {
      return (+this.sodio + (((this.glicemia - 100) / 100) * 1.6))
    },
  }

}
</script>

<style>

</style>
