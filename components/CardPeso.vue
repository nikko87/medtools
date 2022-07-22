<template>
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
</template>

<script>
export default {
    data: () => ({
        peso: null
    })

}
</script>

<style>

</style>
