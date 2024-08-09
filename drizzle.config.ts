import process from 'node:process'
import { defineConfig } from "drizzle-kit"

export default defineConfig({
  schema: "./drizzle/schema/*",
  out: "./drizzle/migrations",
  dialect: "mysql",
  dbCredentials: {
    url: process.env.MYSQL_DATABASE_URL || '',
  },
  verbose: true,
  strict: true,
  // breakpoints: false,
})