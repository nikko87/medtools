<template>
<v-container>

  <v-row justify="center">
    <v-col
      cols="12"
      md="6"
      lg="5"
      sm="8"
      xs="12">


      <v-row>
        <strong>Selecione um medicamento:</strong>
      </v-row>
      <v-row>
        <v-select
          :items="meds"
          item-text="nome"
          label="Medicamentos"
          v-model="medSelected"
          @change="selectMed"
          solo></v-select>

      </v-row>

      <v-row justify="center">
        <strong>Solução padrão: </strong>
      </v-row>
      <v-row justify="center">
        <p class="text-subtitle-2 text-center">
          {{ cur_med.diluicao_padrao }}
        </p>
      </v-row>

      <v-card
        elevation="5"
        class="mb-6"
        shaped>

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
        shaped>

        <v-card-title>Solução</v-card-title>

        <v-divider></v-divider>

        <v-row class="pa-4">

          <v-col>

            <v-row
              justify="center"
              no-gutters>
              <v-icon
                size="64"
                color="green darken-2">
                mdi-test-tube
              </v-icon>

            </v-row>

            <v-row>
              <v-card-text class="subtitle-2 text-center">
                [ {{ getConcSolucao }} mcg/ml ]
              </v-card-text>
            </v-row>

          </v-col>

          <v-col>

            <v-row
              justify="center"
              no-gutters
              align-content="space-between">

              <v-text-field
                v-model="cur_med.conc_padrao_mg"
                label="(mg)"
                outlined
                clearable
                required></v-text-field>

              <v-text-field
                v-model="cur_med.conc_padrao_ml"
                label="(ml)"
                outlined
                clearable
                required></v-text-field>
            </v-row>

          </v-col>

        </v-row>

      </v-card>

      <v-card
        elevation="5"
        shaped
        class="mt-8">

        <v-card-title>Dose</v-card-title>
        <v-divider></v-divider>

        <v-row class="px-4 pt-4">

          <v-col
            cols="5"
            align-self="center">
            <v-text-field
              :label="getLabel"
              v-model="dose"
              outlined 
              clearable />
          </v-col>

          <v-col cols="2">

            <v-btn
              icon
              @click="reverse=!reverse"
              elevation="2">
              <v-icon>mdi-arrow-left-right-bold</v-icon>
            </v-btn>

          </v-col>

          <v-col cols="5">
            <h2
              class="text-center"
              v-if="!reverse"> {{ getResult.toFixed(2) }}
              <p class="text-center">ml/h</p>
            </h2>
            <h2
              class="text-center"
              v-else> {{ getResult.toFixed(2) }}
              <p class="text-center">{{ cur_med.und_medida }}</p>
            </h2>
          </v-col>

        </v-row>

        <v-row
          justify="center"
          :style="[reverse ? {'flex-direction': 'row-reverse'} : '']">

          <h5> {{ cur_med.intervalo_min }} - {{ cur_med.intervalo_max }} {{ cur_med.und_medida }}</h5>
          <v-icon class="px-6">mdi-arrow-right-bold</v-icon>
          <h5> {{ getMin.toFixed(2) }} - {{ getMax.toFixed(2) }} ml/h</h5>

        </v-row>

      </v-card>

    </v-col>
  </v-row>
</v-container>
</template>

<script>
import json from '../static/meds.json';

export default {
  name: 'IndexPage',
  data: function () {
    return {
      cur_med: { },
      peso: 70.0,
      dose: 0.0,
      result: 0.0,
      reverse: false,
      meds: json,
      medSelected: 'Noradrenalina',
    }
  },
  mounted: function () {
    this.selectMed();
  },
  computed: {
    getLabel: function () {
      if (this.reverse) {
        return "ml/h";
      } else {
        return this.cur_med.und_medida;
      }
    },
    getConcSolucao: function () {
      return this.cur_med.conc_padrao_mg / this.cur_med.conc_padrao_ml * 1000;
    },
    // getDose2: function () {
    //     dose2: this.to_mlh(this.dose1, this.peso, this.getConcSolucao, this.cur_med.und_medida)
    // }
    getResult: function () {
      if (!this.reverse) {
        return this.to_mlh(this.dose, this.peso, this.getConcSolucao, this.cur_med.und_medida);
      } else {
        return this.from_mlh(this.dose, this.peso, this.getConcSolucao, this.cur_med.und_medida)
      }
    },
    getMin: function () {
      return this.to_mlh(this.cur_med.intervalo_min, this.peso, this.getConcSolucao, this.cur_med.und_medida);
    },
    getMax: function () {
      return this.to_mlh(this.cur_med.intervalo_max, this.peso, this.getConcSolucao, this.cur_med.und_medida);
    }
  },
  methods: {
    selectMed() {
      // for (var i = 0; i < this.meds.length; i++) {
      //     if (this.meds[i].nome == this.medSelected) {
      //         this.cur_med = this.meds[i];
      //         break;
      //     }
      // }
      for (var k in this.meds) {
        if (this.meds[k].nome == this.medSelected) {
          this.cur_med = this.meds[k];
          break;
        }
      }
    },
    to_mlh(dose, peso, conc, und_origem) {

      switch (und_origem) {
        case 'mcg/kg/min':
          return (dose * peso) / conc * 60;
        case 'mcg/kg/h':
          return (dose * peso) / conc;
        case 'mcg/min':
          return dose / conc * 60;
      }

      return 0.0

    },
    from_mlh(dose, peso, conc, und_destino) {
      switch (und_destino) {
        case 'mcg/kg/min':
          return (dose * conc) / peso / 60;
        case 'mcg/kg/h':
          return dose * conc / peso;
        case 'mcg/min':
          return dose * conc / 60;
      }

      return 0.0

    }
  }
}
</script>
