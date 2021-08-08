import { Component, Input, OnChanges, OnInit, SimpleChanges } from '@angular/core';
import { FormGroup } from '@angular/forms';

import { QuestionBase } from 'src/app/models/question-base';
import { QuestionControlService } from 'src/app/services/question-control.service';

@Component({
  selector: 'app-dynamic-form',
  templateUrl: './dynamic-form.component.html',
  providers: [QuestionControlService]
})
export class DynamicFormComponent implements OnChanges {

  @Input() title: string = '';
  @Input() questions: QuestionBase<string>[] | null = [];
  form!: FormGroup;
  payLoad = '';
  isSendingData: boolean = false;

  constructor(private qcs: QuestionControlService) { }

  ngOnChanges(changes: SimpleChanges): void {
    this.form = this.qcs?.toFormGroup(this.questions as QuestionBase<string>[]);
  }

  /**
   * Simula o envio dos dados com um delay de 2 segundos
   */
  onSubmit() {
    this.isSendingData = true;

    setTimeout(() => {
      this.payLoad = JSON.stringify(this.form.getRawValue());
      this.isSendingData = false;
    }, 2000);
  }
}