import { Length } from "class-validator";
import { BaseEntity, Column, Entity, JoinColumn, ManyToOne, PrimaryGeneratedColumn } from "typeorm";
import { Subsede } from "./subsedeModel";


@Entity('dependencias')
export class Dependencia extends BaseEntity{
    @PrimaryGeneratedColumn({name: 'id_dependencia'})
    idDependencia: number;
    
    @Column("varchar", { length: 100 })
    @Length(3, 50, { message: "El nombre de la dependencia debe tener entre 3 y 50 caracteres" })
    nombre: string;

    @Column("varchar", { length: 100 })
    @Length(3, 50, { message: "El nombre de la dependencia debe tener entre 3 y 50 caracteres" })
    ambiente: string;
    
    @ManyToOne(() => Subsede, (subsede) => subsede.dependencias)
    @JoinColumn({name: 'id_subsede'})
    subsede: Subsede;
}