import { QuestionBase } from './question-base';

/**
 * Classe que será representa por um elemento <select> 
 * Este elemento representa uma lista de opções para o usuário selecionar
 */
export class DropdownQuestion extends QuestionBase<string> {
  controlType = 'dropdown';
}