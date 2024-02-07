import {MessageType} from './enum'

export interface Bank{
  id: number;
  logo: Resource;
  name: string;
  tip?: string;
}

export interface IMessage {
  readonly id: number;
  title: string;
  type: MessageType;
  desc?: string;
  list?: Record<string, string>[]
}