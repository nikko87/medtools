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
        <h1>HIPERNATREMIA</h1>
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

            <p class="text-center mt-2">Déficit de água:  </p>
            <p class="text-center"><b>{{ calcDeficitAgua.toFixed(1) }}ml</b></p>
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
                v-model="sodioDesejado"
                label="Na+ desejado"
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

        <p class="pl-4">- Soro glicosado 5%:</p>
        <p class="pl-4"><b>{{ calcReposicao.sg.toFixed(1) }} ml em 24h </b> ({{ (calcReposicao.sg / 24).toFixed(1)}} ml/h)</p>

        <p class="pl-4">- Sol. salina a 0.2%:</p>
        <p class="pl-4"><b>{{ calcReposicao.s02.toFixed(1) }} ml em 24h </b> ({{ (calcReposicao.s02 / 24).toFixed(1)}} ml/h)</p>

        <p class="pl-4">- Sol. salina a 0.45%:</p>
        <p class="pl-4"><b>{{ calcReposicao.s045.toFixed(1) }} ml em 24h </b> ({{ (calcReposicao.s045 / 24).toFixed(1)}} ml/h)</p>


        <!-- <v-card-text><strong>{{ (calc21h/21).toFixed(1)}}ml/h </strong> nas próximas 21h <small>({{ calc21h.toFixed(1) }}ml)</small> </v-card-text> -->

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
      sodio: 150,
      sodioDesejado: 140,
      mulher: false,
    }
  },
  methods: {
  },
  computed: {
    calcDeficitAgua: function () {
      let offset = this.mulher ? 0.4 : 0.5;
      return (offset * this.peso) * ((this.sodio / this.sodioDesejado) - 1) * 1000 // L => ml
    },
    calcReposicao: function () {
        return {
            sg: this.calcDeficitAgua,
            s02: this.calcDeficitAgua * 1.33,
            s045: this.calcDeficitAgua * 2,
        }
    },
  }

}
</script>

<style>

</style>
