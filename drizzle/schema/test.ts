import {mysqlTable, bigint, varchar, timestamp, date, index,} from "drizzle-orm/mysql-core"
import { createInsertSchema, createSelectSchema } from 'drizzle-zod'
import type { z } from 'zod'
  
export const test = mysqlTable("test",{
  id: bigint("id", { mode: "number" }).primaryKey().autoincrement().notNull(),
  name: varchar("test", { length: 50 }).notNull(),
  createdAt: timestamp("created_at"),
  updatedAt: timestamp("updated_at"),
  deletedAt: timestamp("deleted_at"),
})

export const testInsertSchema = createInsertSchema(test)
export const testSchema = createSelectSchema(test)
export type Test = z.infer<typeof testSchema>